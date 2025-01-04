#!/bin/bash

# Set the Websense directory
websensePath="/Library/Application Support/Websense Endpoint/EPClassifier"
configFilePath="$websensePath/localconfig.xml"
password="Put yor antitampering password here"

# Navigate to the Websense directory
cd "$websensePath" || { echo "Failed to navigate to $websensePath. Directory not found."; exit 1; }

# Stop services and disable anti-tampering
echo "Disabling anti-tampering..."
wepsvc --disable-anti-tampering --wsdlp --password "$password"

echo "Stopping all services..."
wepsvc --stop --all --password "$password"

#below is a sample localconfig file for your reference

# Check if the XML file exists
if [[ -f "$configFilePath" ]]; then
    echo "Backing up existing localconfig.xml..."
    cp "$configFilePath" "${configFilePath}.bak"

    echo "Replacing the content of localconfig.xml..."
    cat <<EOF > "$configFilePath"
<ClassifierConfiguration>
    <ClassifierConfigVersion>6</ClassifierConfigVersion>
    <ConfigUpdateRate>600</ConfigUpdateRate>
    <checkDisconnectedEndpointIntervalInSeconds>172800</checkDisconnectedEndpointIntervalInSeconds>
    <checkDisconnectedIntervalUpdateRateInSeconds>86400</checkDisconnectedIntervalUpdateRateInSeconds>
    <ConnectivityTestRate>300</ConnectivityTestRate>
    <SendUnconfirmedIncidents>1</SendUnconfirmedIncidents>
    <ReselectServerRate>600</ReselectServerRate>
    <ReselectServerOnFailRate>120</ReselectServerOnFailRate>
    <IncidentsFolderSize>104857600</IncidentsFolderSize>
    <EnforceFIPS>0</EnforceFIPS>
    <EnforceAdminPasswordFIPS>0</EnforceAdminPasswordFIPS>
    <ConfirmFolderSize>26214400</ConfirmFolderSize>
    <InstallationID>0</InstallationID>
    <MaxRAMSpace>20000000</MaxRAMSpace>
    <MaxDiskSpace>110000000</MaxDiskSpace>
    
    
    <Servers ProfileID="0">
      <Primary>
        <Server>
          <URL>https://ForcepointDLP/EP/EndpointServer.dll</URL>
          <URL>https://192.168.122.21/EP/EndpointServer.dll</URL>
</Server>
</Primary>
      <Secondary>
        <Server>
          <URL>https://WIN-9QU4V029MQ7/EP/EndpointServer.dll</URL>
          <URL>https://192.168.122.218/EP/EndpointServer.dll</URL>
</Server>
</Secondary>
</Servers>
    <HugeFileSettings HugeFilePrefixSizeMB="5" HugeFileSuffixSizeMB="5" MaxFileInRamSizeMB="10">
      <HugeFileSettingByChannel ChannelType="16" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="2" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="7" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="9" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="10" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="11" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="12" HugeFileLimitMB="100"/>
      <HugeFileSettingByChannel ChannelType="14" HugeFileLimitMB="100"/>
</HugeFileSettings>
    <SupportDeflate>1</SupportDeflate>
    <MaxBytesPerSec>-1</MaxBytesPerSec>
</ClassifierConfiguration>
EOF
    echo "Replacement completed successfully!"
else
    echo "localconfig.xml not found at $configFilePath. Exiting without changes."
    exit 1
fi

# Start services and enable anti-tampering
echo "Starting all services..."
wepsvc --start --all

echo "Enabling anti-tampering..."
wepsvc --enable-anti-tampering --wsdlp --password "$password"

# Pause to keep the terminal open
read -p "Press any key to exit..."
echo "Done."
