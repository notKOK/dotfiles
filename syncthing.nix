{
  config,
  pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "danila";
    dataDir = "/home/danila"; # Базовая директория Syncthing
    #configDir = "/home/your-user/.config/syncthing";  # Где хранится конфигурация

    settings = {
      devices = {
        "phone" = {
          id = "2J7HBUO-QL455SA-MDBNFU2-MMO2XOU-X4NAX7K-D3QCLK7-I5FR67A-4MKUCQX";
        };
      };

      folders = {
        "Cusick-fold" = {
          id = "mdlwi-8zdfl";
          path = "/home/danila/AddedByMe/Cusick"; # Папка для синхронизации
          devices = ["phone"]; # Устройства, которые должны её синхронизировать
        };
      };
    };
  };
}
