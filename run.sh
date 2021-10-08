#!/bin/bash

printf "\nWelcome to this demo of fractionalizing a NFT. This demo first mints a NFT which then will be locked in a script where it can be fractionalized and later the fraction tokens got burned and we get the NFT back.\n"
printf "\n This is only to demonstrate how it works therefore we only use one wallet in the whole demo, but you are free to add complexity.\n"
printf "\n"
export userWallet=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1


export userW_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "NFTContract", "caWallet":{"getWalletId": '$userWallet'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 1


printf "\n1. First, we mint the NFT which will be named NFT.\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

curl -H "Content-Type: application/json" -X POST -d '{"unTokenName":"NFT"}' http://localhost:9080/api/contract/instance/$userW_IID/endpoint/mint 
sleep 1
printf "\n"

sleep 2
printf "\n"
printf "\nYou can see in the server log that the NFT is minted.\n"
printf "\n"
sleep 1
read -p "Please copy the currency symbol (the string between the two Maps) and paste here:   " tokenSymbol
printf "\n"
export userWF_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "FracadaContract", "caWallet":{"getWalletId":'$userWallet'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')

sleep 1
printf "\n"

printf "\n2. Next we lock the NFT in the FracadaContract.\n"
read -n1 -r -p "Press any key to continue..." key

printf "\n"
curl -H "Content-Type: application/json" -X POST -d '{"unAssetClass":[{"unCurrencySymbol":"'$tokenSymbol'"},{"unTokenName":"NFT"}]}' http://localhost:9080/api/contract/instance/$userWF_IID/endpoint/1-lockNFT 
sleep 1
printf "\n"
sleep 2
printf "\n"

printf "\nYou can see in the server logs, the NFT is now locked in the Contract.\n"
read -n1 -r -p "Press any key to continue..." key

printf "\n"

printf "\n3. The next steep is to fractionalize the locked NFT and get the fraction tokens.\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"
sleep 2
curl -H "Content-Type: application/json" --request POST --data '{"nftAsset":{"unAssetClass":[{"unCurrencySymbol":"'$tokenSymbol'"},{"unTokenName":"NFT"}]},"fractions":100,"fractionTokenName":{"unTokenName":"fractNFT"}}' http://localhost:9080/api/contract/instance/$userWF_IID/endpoint/2-fractionNFT
sleep 1
printf "\n"

sleep 2
printf "\n"
printf "The server log shows now that the NFT is fractionied to 100 pieces, we now could send them to anybody we want." 
read -n1 -r -p "Press any key to continue..." key
printf "\n"
printf "\n"
sleep 1 

printf "\n4. If we have all the fraction tokens back we now can burn them and get the NFT back.\n"
read -n1 -r -p "Press any key to continue..."
printf "\n"
sleep 2 
curl -H "Content-Type: application/json" --request POST --data '{"unAssetClass":[{"unCurrencySymbol":"'$tokenSymbol'"},{"unTokenName":"NFT"}]}' http://localhost:9080/api/contract/instance/$userWF_IID/endpoint/3-returnNFT
printf "\n"
sleep 1 
printf "\n"

sleep 2 
printf "\n"
printf "\nIn the server lock it shows that the tokens are burned. The Contract also automatically returns the NFT\n" 
read -n1 -r -p "Press any key to continue.." key
sleep 2
printf "\n"
printf "\nIf you close the server connection, now you can see that the NFT is back in your wallet.\n"
read -n1 -r -p "Press any key to continue.."
printf "\n"
sleep 2
printf "\nThank you for your time.\n"
printf "\n"


