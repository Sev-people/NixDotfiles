{ ... }:

{

  programs.wofi = {
    enable = true;
    settings = {
      mode="drun";
      allow_images=true;
      image_size=32;
      width="20%";
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
              background-color: rgba(22, 19, 32, 0.9);
              color: #f8f8f2;
              border-radius: 5px;
      }      
             
      #entry {
              padding: 0.5em;
      }      
             
      #entry:selected {
              background-color: #C73770;
              color: #161320;
              background: linear-gradient(90deg, #C73770, #d6c84c);
      }      
             
      #text:selected {
              color: #161320;
      }      
             
      #input {
              background-color: rgba(22, 19, 32, 0.9);
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
