{ ... }:

{

  programs.wofi = {
    enable = true;
    settings = {
      mode="drun";
      width="40%";
      columns=3;
      normal_window=true;
    };
  };
  home.file.".config/wofi/style.css" = {
    text = ''
      * {                                                                                     
              border: none;
      }      
             
      #outer-box {
              border-radius: 5px;
      }      
             
      #window {
              font-size: 16px;
              font-family: "JetbrainsMono Nerd Font";
              background-color: #1c1416;
              color: #f8f8f2;
              border-radius: 5px;
      }      
             
      #entry {
              padding: 0.5em;
      }      
             
      #entry:selected {
              background-color: #C73770;
              color: #161320;
      }      
             
      #text:selected {
              color: #161320;
      }      
             
      #input {
              background-color: #1c1416;
              color: #f8f8f2;
              padding: 0.5em;
              border-radius: 5px 5px 0px 0px;
      }      
             
      image {
              margin-left: 0.25em;
              margin-right: 0.4em;
      }      
    '';
  };

}
