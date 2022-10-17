# What is Unbloater❓
![Main menu](https://github.com/anupamjaiswall/Unbloater/blob/main/media/main_menu.png?raw=true)
**Unbloater uses [ADB](https://developer.android.com/studio/command-line/adb) functionality to provide:**
* Installation of one or multiple packages.
* To list installed packages.
* To remove nearly every package(application) without requiring root access.
    * **The advantages of removing these packages :**

        1.  Make more space (useful for devices with limited storage).

        2.  No more spies by the bloatwares(applications installed by device manufacturers).

        3.  No more advertisements by those bloatwares.

* Launch the ADB shell.
* Extract APK with user data.
* To create an ADB backup and restore the backup.

# Installtion of Unbloater :
1. Open your terminal.
2. Run the following commands :
```bash
wget https://raw.githubusercontent.com/anupamjaiswall/Unbloater/main/Unbloater.sh
bash Unbloater.sh
```

# 0) To Install on debian based distros :
![installation](https://github.com/anupamjaiswall/Unbloater/blob/main/media/0.gif?raw=true)
Choose 0 from the main menu to install ADB on debian based distros.

# D/d) Detecting or selecting a device :
![detection](https://github.com/anupamjaiswall/Unbloater/blob/main/media/2detection.png?raw=true)
Enable [USB debugging](https://www.embarcadero.com/starthere/xe5/mobdevsetup/android/en/enabling_usb_debugging_on_an_android_device.html) on your phone from developer options and Choose *d* or *D* to detect plugged in availble devices.

# 1) To access the ADB shell :
![ADB shell](https://github.com/anupamjaiswall/Unbloater/blob/main/media/1adb_shell.png?raw=true)
Choose *1* execute the ADB shell

# 2) To list packages :
![packages](https://github.com/anupamjaiswall/Unbloater/blob/main/media/2.gif?raw=true)
Choose option *2* to see list of packages installed on your device.

# 3 & 4)
![search and remove](https://github.com/anupamjaiswall/Unbloater/blob/main/media/3-and-4.gif?raw=true)
Choose option *4* to search for the package number, if you don't know the name of the package, you can use [APK Inspector](https://play.google.com/store/apps/details?id=net.jevinstudios.apkinspector&hl=en_IN&gl=US), write down all the package numbers for the packages you want remove from your device.
now choose option *3* and write all those package numbers.
**Syntax**
```bash
[num1] [num2] ...
```
**⚠️  Warning :**
The removal of some packages can make your device brick, so please don't remove those packages which are necessary for the functionality of your phone. You will have to hard reset the device if you get into this trouble.

# 5) Installing a single or multiple APKs :
![install list of APKs](https://github.com/anupamjaiswall/Unbloater/blob/main/media/5.gif?raw=true)
Choose option *5* to install multiple apks.
**Syntax**
```bash
path1/of/file.apk path2/of/file2.apk
```

# 6) Installing multiple APKs from a directory :
![installing APKs from a directory](https://github.com/anupamjaiswall/Unbloater/blob/main/media/6.gif?raw=true)
Choose option *6* to install multiple apks from a directory.
**Syntax**
```bash
path/of/the/directory/
```

# 7) Extracting APKs :
![extraction of APKs](https://github.com/anupamjaiswall/Unbloater/blob/main/media/7.gif?raw=true)
Choose option *7* to extract APKs. Extracted APKs will be saved in *adb_backup* directory.

# 8) Creating ADB backup:
![ADB backup](https://github.com/anupamjaiswall/Unbloater/blob/main/media/8.gif?raw=true)
Choose option *8* to create ADB backup, select *back up my data* on your device(giving password is not mandatory).

# 9) To restore the ADB backup, do the following :
![ADB restore](https://github.com/anupamjaiswall/Unbloater/blob/main/media/9.gif?raw=true)
Choose option *9*, give path of backup file, selcet restore my data on your device(give password if you had given while creating the backup)

# GNU General Public License
Feel free to use and contribute 😉

### Did you like this project? How about getting me a [coffee🍵](https://www.buymeacoffee.com/anupamjaiswall)?
