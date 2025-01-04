# Websense Endpoint Configuration Management

This repository contains a Bash script used for managing the Websense Endpoint service configuration. The script performs the following operations:

- **Backup** the existing `localconfig.xml` file.
- **Replace** the content of the configuration file with a predefined setup.
- **Stop** Websense services and **disable** anti-tampering during the process.
- **Restart** Websense services and **enable** anti-tampering after the update.

### Prerequisites

Ensure the following are installed and configured before running the script:

- Websense Endpoint services are installed.
- Sufficient permissions to stop services and modify files in the Websense directory.
- The `wepsvc` command-line tool must be accessible and configured for managing services.

### Installation

1. Clone the repository:
 
 git clone https://github.com/yourusername/Websense-Endpoint-Configuration-Management.git
Navigate to the repository folder:


cd Websense-Endpoint-Configuration-Management
Ensure the script has executable permissions:


chmod +x manage_websense.sh
Usage
Run the script:

./manage_websense.sh
The script will:

Stop Websense services.

Back up the current localconfig.xml.
Replace the configuration with predefined settings.
Restart the services and re-enable anti-tampering.

Configuration Details
The script is designed to modify the localconfig.xml with settings for:

Server URLs

Incident folder size
Huge file handling
Connectivity and reconnection intervals
FIPS (Federal Information Processing Standards) compliance settings
License
This repository is licensed under the MIT License.

Contributing

Feel free to fork the repository, create an issue, or submit a pull request if you would like to contribute improvements or bug fixes.
