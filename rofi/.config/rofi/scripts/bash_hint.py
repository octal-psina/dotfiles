command_description = [{"Goto BEGINNING of command line": "ctrl + a"},
{"Goto END of command line": "ctrl + e"}, 	
{"Move back one character": "ctrl + b"},
{"Move forward one character": "ctrl + f"}, 	
{"Move cursor FORWARD one word": "alt + f"}, 	
{"Move cursor BACK one word": "alt + b"}, 	
{'Delete the character under the cursor': 'ctrl + d'}, 	
{'Delete the previous character before cursor': 'ctrl + h'}, 	
{'Clear all / cut BEFORE cursor': 'ctrl + u'},
{'Clear all / cut AFTER cursor': 'ctrl + k'}, 	
{'Delete the word BEFORE the cursor': 'ctrl + w'}, 	
{'Delete the word FROM the cursor': 'alt + d'}, 	
{'Paste': 'ctrl + y'}, 	
{'Command completion like': 'Tab ctrl + i'}, 	
{'Clear the screen (same as clear command)': 'ctrl + l'}, 	
{'Kill whatever is running': 'ctrl + c'}, 	
{'Exit shell': 'ctrl + d'}, 	
{'Place current process in background': 'ctrl + z'}, 	
{'Undo': 'ctrl + _'}, 	
{'Swap the last two characters before the cursor': 'ctrl + t'},	
{'Swap last two words before the cursor': 'esc + t'}, 	
{'Swap current word with previous': 'alt + t'}, 	
{'Delete PREVIOUS word': 'alt + [Backspace]'},
{'Make uppercase from cursor to end of word': 'alt + u'},
{'Make lowercase from cursor to end of word': 'alt + l'},	
{'Non-incremental reverse search of history': 'alt + p'}, 	
{'Undo all changes to the line': 'alt + r'},
{'Expand command line': 'alt + ctl +'}, 
{'Display file/folder names': 'alt + ?'},	
{'Print all the file/folder names': 'alt + *'}, 

{'Undo the last changes': 'ctrl + x ctrl + u'}, 	
	
{'Print the LAST ARGUMENT (ie "vim file1.txt file2.txt" will yield "file2.txt")': 'alt + .'}, 	
{'Capitalize the first character to end of word starting at cursor (whole word if cursor is at the beginning of word)': 'alt + c'}, 
{"Toggle between the start & current position": "ctrl + xx"},]
def show_me_the_list(list_of_items):
  for item in list_of_items:
    for key,value in item.items():
      print(f"{key}: {value}\n")

show_me_the_list(command_description)

