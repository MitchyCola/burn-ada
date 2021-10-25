# Proof-of-Burn Challenge 🔥

## Introduction 👋
Some members of the cryptocurrency community requested a proof-of-burn mechanism on the Cardano network. The belief is that the systematic descruciton of coins, "burning", will increase the scarcity of the remaining coins and should artifically inflate the demand for the coins. This feature has been requested in the Cardano ecosystem due to the Ethereum network incorporating [EIP-1559](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1559.md).

Charles Hoskinson got so many messages requesting this feature, that he issued a [challenge](https://www.youtube.com/watch?v=KaLZJs5Y_rE) for developers to engineer a system taht would allow people to burn the coins that they wished to destroy.

My stance on Proof-of-Burn is that people should not be forced to destroy their money when they want to preform mundane transactions. I believe that this incetivizes the hoarding of cryptocurreny, and will mainly benefit the people who already have a massive sum of crypto. Now, I do belive each and every person has the right to use their legally owned crypto how ever they desire. So, if people are willing to volunteer their crypto for the sake of ultrasound money 🦇, then more power to them.

I decided to make my own implementation of Proof-of-Burn, because I thought it would be a fun, little project that would also give me some experince developing on Cardano.

---

## Development 👨🏽‍💻
Each folder will contain more information about their respective topic, but here is a brief overivew.

In essence, there are two methods a person could use to burn Ada, both of these methods would involve sendind the Ada to burn address:
 
    1. The first method would be to write a Plutus script that would create a smart contract with infinite time-to-live and would also have a redeemer that would be impossible to satisfy, then people would send their Ada to the script address where it would remain forever.

    2. The second method would entail creating a regular address, but the private keys for the address would never be saved or seen. Meaning, any Ada that would be sent to that address can never be spent.

Personally, I decided to continue with the second method because it is much easier to grasp, mentally. If you would like an example of a solution that similar to the way I described the first method, then I wuold recommend looking into [Iagon's solution](https://blog.iagon.com/iagons-solution-to-the-cardano-proof-of-burn-challenge/).

---

## Deployment 📦
Once I figured out the process for creating a burn address, I faced the issue of being able to create the address so that people can verify that I actually used the code that I wrote. So that they do not have to just trust that I did not use an address that I already owned. There were a few paths that I was considering, like essentailly getting a signed certificate for the code. But it still would not have solved the issue of people needing to trust that I did everything above board.

I realeized that problem was that I could not easily prove that the code that I ran on my local machine is the same code that is in this GitHub repository. Therefore, I determined that I needed to have a remote machine execute the portion of the code that is responsible for creating a random address, with a record of the results. GitHub Actions can be used to accomplish all of these requirements.

---
