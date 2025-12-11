![Static Badge](https://img.shields.io/badge/AltherPride-black?style=for-the-badge&logo=discord&color=%23ffbf00&link=https%3A%2F%2Fdiscord.gg%2FfcQwMekMmt)
![License](https://img.shields.io/github/license/AltherPride/samp-cache-wizard?style=for-the-badge)
![Last Commit](https://img.shields.io/github/last-commit/AltherPride/samp-cache-wizard?style=for-the-badge)

## Automatic Program Update/Download AltherPride Models

This program is a **Batch Utility** designed to automatically manage and update the SA-MP (San Andreas Multiplayer) model cache, with a command-line interface.

### What does this program do?
- Create a temporary folder at `%TEMP%`
- Downloading the newest cache file from the AltherPride server
- Scanning the directory `C:\Users\...\Documents\GTA San Andreas User Files\SAMP\cache`
- If there is old cache, you will be given the choice to delete it or not
- Extract and copy the new cache to the directory `C:\Users\...\Documents\GTA San Andreas User Files\SAMP\cache`
- Clean files, temporary folders, and leftover residues after the process is complete

### Notes
This script only supports **Windows with PowerShell**.  
Make sure your internet connection is stable before running this program, and make sure you have access rights to the SA-MP cache directory.