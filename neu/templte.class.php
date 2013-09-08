<?php
class Template {
    
    public function __construct($file) {
        $this->file = "templates/".$file;
    }
    
    public function assign($key, $value) {
        $this->values[$key] = $value;
    }

    public function display() {
        if (!file_exists($this->file)) {
        	return "Error loading template file ($this->file).<br />";
        }
        $output = file_get_contents($this->file);
        
        foreach ($this->values as $key => $value) {
        	$tagToReplace = "[$key]";
        	$output = str_replace($tagToReplace, $value, $output);
        }

        print $output;
    }
}
?>