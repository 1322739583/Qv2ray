# Packaging
set(CPACK_PACKAGE_VENDOR "Qv2ray Development Group")
set(CPACK_PACKAGE_VERSION ${QV2RAY_VERSION_STRING})
set(CPACK_PACKAGE_DESCRIPTION "Cross-platform V2Ray Client written in Qt.")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://github.com/Qv2ray/Qv2ray")
set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/assets/icons/qv2ray.ico")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")

if(MSVC)
    set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION .)
    include(InstallRequiredSystemLibraries)
    if(BUILD_NSIS)
        add_definitions(-DQV2RAY_NO_ASIDECONFIG)
        set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/assets/icons\\\\qv2ray.ico")
        set(CPACK_GENERATOR "NSIS")
        set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}/assets/icons/qv2ray.ico")
        set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}/assets/icons/qv2ray.ico")
        set(CPACK_NSIS_DISPLAY_NAME "Qv2ray")
        set(CPACK_NSIS_PACKAGE_NAME "Qv2ray")
        set(CPACK_NSIS_EXTRA_PREINSTALL_COMMANDS "
            ExecWait \\\"taskkill /f /im qv2ray.exe\\\"
        ")
        set(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
            CreateShortCut \\\"$DESKTOP\\\\Qv2ray.lnk\\\" \\\"$INSTDIR\\\\qv2ray.exe\\\"
            CreateDirectory \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Qv2ray\\\"
            CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Qv2ray\\\\Qv2ray.lnk\\\" \\\"$INSTDIR\\\\qv2ray.exe\\\"
            WriteRegStr HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\" \\\"DisplayIcon\\\" \\\"$INSTDIR\\\\qv2ray.exe\\\"
            WriteRegStr HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\" \\\"HelpLink\\\" \\\"https://qv2ray.github.io\\\"
            WriteRegStr HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\" \\\"InstallLocation\\\" \\\"$INSTDIR\\\"
            WriteRegStr HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\" \\\"URLUpdateInfo\\\" \\\"https://github.com/Qv2ray/Qv2ray/releases\\\"
            WriteRegStr HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\" \\\"URLInfoAbout\\\" \\\"https://github.com/Qv2ray/Qv2ray\\\"
        ")
        set(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "
            ExecWait \\\"taskkill /f /im qv2ray.exe\\\"
            Delete \\\"$DESKTOP\\\\Qv2ray.lnk\\\"
            Delete \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Qv2ray\\\\Qv2ray.lnk\\\"
            RMDir \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Qv2ray\\\"
            DeleteRegKey HKLM \\\"Software\\\\Microsoft\\\\Windows\\\\CurrentVersion\\\\Uninstall\\\\qv2ray\\\"
        ")
        set(CPACK_PACKAGE_INSTALL_DIRECTORY "qv2ray")
    endif()
endif()

if(APPLE)
    set(CPACK_GENERATOR "DragNDrop")
    if(DS_STORE_SCRIPT)
        set(CPACK_DMG_DS_STORE_SETUP_SCRIPT "${CMAKE_SOURCE_DIR}/cmake/CMakeDMGSetup.scpt")
    else()
        set(CPACK_DMG_DS_STORE "${CMAKE_SOURCE_DIR}/assets/DS_Store")
    endif()
    
    set(CPACK_DMG_BACKGROUND_IMAGE "${CMAKE_SOURCE_DIR}/assets/CMakeDMGBackground.png")
endif()

include(CPack)
