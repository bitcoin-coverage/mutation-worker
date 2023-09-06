<h1 align="center">
  <br>
  <a href="https://btc-coverage.aureleoules.com"><img src="https://github.com/bitcoin-coverage/core/raw/master/docs/assets/logo.png" alt="Bitcoin Coverage" width="200"></a>
  <br>
    Mutation Worker
  <br>
</h1>

<h4 align="center">Tests generated mutations of <a href="https://github.com/bitcoin/bitcoin" target="_blank">Bitcoin Core</a> pull requests.</h4>

## 📖 Introduction
This repository contains the code of the worker that runs the mutation jobs of Bitcoin Core pull requests.

## 🚀 How it works
The worker executes the following steps:
1. Clone the Bitcoin Core repository
2. Checkout the pull request branch
3. Apply the patch
4. Compile Bitcoin Core
5. Run the tests

## 📦 Docker
This Docker image is automatically built and deployed to AWS ECR on every push to `master` branch.

## 📝 License

MIT - [Aurèle Oulès](https://github.com/aureleoules)
