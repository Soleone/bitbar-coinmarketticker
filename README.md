# Coinmarketticker

Shows selected cryptocurrencies rates from Coinmarketcap using Ruby.

![screenshot](https://i.imgur.com/dyJPNy7.png)

## Usage

1. Install BitBar: https://github.com/matryer/bitbar#get-started
2. Copy `coinmarketticker.rb` to your plugins folder, most likely in `~/Documents/Bitbar-Plugins`
3. Start or refresh BitBar

## Customization

You can edit the script which is fairly readable to customize some of the display options:

* Edit your coins of choice below by editing COINS.
* Change your period between 1h, 24h or 7d by editing DEFAULT_PERIOD.

## Troubleshooting

### 1. `launch path not accessible`

This error typically means that the plugin script file does not have permission to execute. You can fix this by explicitly allowing the file to be executable using the following steps.

1. Open `Terminal.app` from your `Applications`
2. Run the following command to give permissions to the plugin file:

`chmod +x ~/Documents/Bitbar-Plugins/coinmarketticker.rb`

Keep it mind that if you created your plugin folder in a different location you have to adjust that command accordingly. If everything goes right you won't see any output after running the command, meaning it worked.

Restart BitBar or click Refresh All to see if it worked.

###  2. `couldn’t posix_spawn: error 8`

This most likely means the plugin file was not correctly downloaded. Make sure from your browser you "Save as..." and then store it in your Bitbar plugins directory. It should be named exactly like this: `coinmarketticker.rb`.
