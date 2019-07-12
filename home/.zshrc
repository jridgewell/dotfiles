##########################
# Source zsh Custom ######
##########################
for config_file ($HOME/.zsh/custom/*.zsh); do
    source $config_file
done

##########################
# Source zsh Config ######
##########################
for config_file ($HOME/.zsh/config/*.zsh); do
    source $config_file
done

##########################
# Source zsh Functions ###
##########################
for config_file ($HOME/.zsh/functions/*.zsh); do
    source $config_file
done

##########################
# Source zsh Plugins #####
##########################
for config_file ($HOME/.zsh/plugins/*.zsh); do
    source $config_file
done
unset config_file
