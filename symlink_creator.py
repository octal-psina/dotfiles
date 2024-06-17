# Script copy files from ~/.config/<package> -> ~/dotfiles/<package>/.config/package 
import os
import shutil

# list of files to copy 
config = [ 'i3', 'i3status', 'gtk-3.0', 'dunst',  'kitty', 'picom', 'starship.toml',  'sublime-text', 'QtProject.conf', 'btop',  'xpad', 'fastfetch', 'test']

def file_gather(usr,*args,):
    """Make directories and move dotfile there then make symlink using 'stow'"""
    #src = '/home/{usr}/.config/test'
    #dest = '/home/{usr}/{0}/.config/{0}'
    #stow_directory/nvim/.config/nvim
    for arg in args:
        # use list of files from .config to make new directories
        for dir in arg:
            try:
                src = f'/home/{usr}/.config/{dir}'
                dest = f'/home/{usr}/dotfiles/{dir}/.config'
                if os.path.exists(src) and not os.path.exists(dest.rstrip("/.config")):
                    os.mkdir('/home/{0}/dotfiles/{1}/'.format(usr,dir))
                    #os.mkdir('/home/{usr}/dotfiles/{0}/.config'.format(dir))
                    os.mkdir(dest)
                    #shutil.copytree(src, dest+'/'+dir) 
                    shutil.move(src, dest+'/'+dir) 
                    os.system(f"stow {dir}")
                else:
                    continue
            except(FileNotFoundError):
                continue
        print("Compleat.")

def get_dirlist(usr):
    """Get list of files from .config"""
    dir_list = os.listdir(f'/home/{usr}/.config/')
    print(dir_list)

user = "name" # replace the "name" with your username
#guess nvim should be the first becouse of convinient 
#list_files = ['nvim']
file_gather(user, config)
#get_dirlist(user)
