# fracada-plutus-starter
This repository is the plutus-starter implementation of the [fracada](https://github.com/dcSpark/fracada) contract, with which we can fractionalize a NFT. 
For testing there is also a contract to mint a NFT. 


### Setting up
Please refer to [Setting up](https://github.com/input-output-hk/plutus-starter#setting-up) section of the plutus starter project.

### The Plutus Application Backend (PAB)

With the PAB we can serve and interact with contracts over a web API. You can read more about the PAB here: [PAB Architecture](https://github.com/input-output-hk/plutus/blob/master/plutus-pab/ARCHITECTURE.adoc).

Here, the PAB is configured with two contracts, `MintNFT` and `Fracada` contracts under `/src` folder.



### Steps to run the demo

1. Perform the setup for **Plutus** as described in the plutus starter project.
2. Clone this repo to your local environment.
3. Start a nix shell from the plutus repo from the first step.
4. Build the PAB executable:
```
cabal build fracada-pab
```
5. Run the PAB binary:
 ```
cabal exec -- fracada-pab
````
6. Now, execute `run.sh` for the demo. You might need to do `chmod +x run.sh` first in case execute permissions are missing.

### Support/Issues/Community

If you're looking for support, or would simply like to report a bug, feature
request, etc. please do so over on the main [plutus repository](https://github.com/input-output-hk/plutus).


Thanks!








