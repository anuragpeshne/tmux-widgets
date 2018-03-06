# tmux-widgets
text based widgets for tmux

![demo](https://github.com/anuragpeshne/tmux-widgets/blob/master/img/tmux-widget.gif)

# Installation
1. Clone this repository
   - ```git clone https://github.com/anuragpeshne/tmux-widgets ~/code/tmux-widgets```
2. Set variables for weather:
   - ```cd ~/code/tmux-widgets```
   - ```cp vars_template vars```
   - Get free API key from http://openweathermap.org/
3. If using OSX, install ```istats``` for HW temperature and battery status:
   ```gem install iStats```
4. Set widget path in `.tmux_conf`:
   - ```set -g status-right "#[fg=green][#[default]#($HOME/code/tmux-widgets/main)#[fg=green]] #[fg=cyan]%d %b %R"```
   - ```set -g status-interval 40```
