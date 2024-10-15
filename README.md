# GitHub Self-Hosted Runner

This project provides a self-hosted runner for GitHub Actions equiped with nodejs and npm, designed to be run on a VPS (Virtual Private Server). Using a self-hosted runner offers several advantages:

- Network privileges
- Fixed IP address
- Cost-effective solution (it's free! 😄)

## Prerequisites

Before you begin, ensure you have the following:

- Docker and Docker Compose installed on your VPS
- A GitHub account with appropriate permissions to set up runners

## Environment Variables

You'll need to set the following environment variables:

- `GITHUB_PAT`: Personal Access Token for GitHub
- `GITHUB_OWNER`: The GitHub username or organization name
- `GITHUB_REPO`: The name of the repository where you want to use this runner

## Initialization

To start the runner(s), follow these steps:

1. Clone this repository to your VPS.
2. Navigate to the project directory.
3. Set the required environment variables (see above).
4. Use the following Docker Compose command to build and start the runners:

   ```bash
   docker-compose up --build -d --scale runner=<number_of_runners>
   ```

   Replace `<number_of_runners>` with the desired number of runner instances. For example, to start 3 runners:

   ```bash
   docker-compose up --build -d --scale runner=3
   ```
