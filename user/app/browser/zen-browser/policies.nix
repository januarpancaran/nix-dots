{userSettings, ...}: {
  programs.zen-browser.policies = {
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DontCheckDefaultBrowser = true;
    DisablePocket = true;
    DisableFirefoxAccounts = true;
    DisableAccounts = true;
    DisplayBookmarksToolbar = "always";
    SearchBar = "unified";

    DefaultDownloadDirectory = "/home/" + userSettings.username + "/Downloads";

    ExtensionSettings = let
      extension = shortId: uuid: {
        name = uuid;
        value = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    in
      builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "always-visible" "{4b7825da-0dd1-44f9-9717-bee5b2408af6}")
      ];

    Preferences = let
      lock-false = {
        Value = false;
        Status = "locked";
      };

      lock-true = {
        Value = true;
        Status = "locked";
      };

      lock-empty-string = {
        Value = "";
        Status = "locked";
      };
    in {
      "content.notify.interval" = 100000;

      # GFX
      "gfx.canvas.accelerated.cache-items" = 4096;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 20;

      # Disk Cache
      "browser.cache.disk.enable" = lock-true;

      # Media Cache
      "media.memory_cache_max_size" = 65536;
      "media.cache_readahead_limit" = 7200;
      "media.cache_resume_threshold" = 3600;

      # Image Cache
      "image.mem.decode_bytes_at_a_time" = 32768;

      # Network
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 10;
      "network.http.max-urgent-start-excessive-connections-per-host" = 5;
      "network.http.pacing.requests.enabled" = lock-false;
      "network.dnsCacheExpiration" = 3600;
      "network.ssl_tokens_cache_capacity" = 10240;

      # Speculative Loading
      "network.dns.disablePrefetch" = lock-true;
      "network.dns.disablePrefetchFromHTTPS" = lock-true;
      "network.prefetch-next" = lock-false;
      "network.predictor.enabled" = lock-false;
      "network.predictor.enable-prefetch" = lock-false;

      # Experimental
      "layout.css.grid-template-masonry-value.enabled" = lock-true;
      "dom.enable_web_task_scheduling" = lock-true;

      # Tracking Protection
      "browser.contentblocking.category" = {
        Value = "strict";
        Status = "locked";
      };
      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
      "browser.download.start_downloads_in_tmp_dir" = lock-true;
      "browser.download.useDownloadDir" = lock-false;
      "browser.helperApps.deleteTempFileOnExit" = lock-true;
      "browser.uitour.enabled" = lock-false;
      "privacy.globalprivacycontrol.enabled" = lock-true;

      # OSCP & CERTS / HPKP
      "security.OCSP.enabled" = 0;
      "security.remote_settings.crlite_filters.enabled" = lock-true;
      "security.pki.crlite_mode" = 2;

      # SSL / TLS
      "security.ssl.treat_unsafe_negotiation_as_broken" = lock-true;
      "browser.xul.error_pages.expert_bad_cert" = lock-true;
      "security.tls.enable_0rtt_data" = lock-false;

      # Disk Avoidance
      "browser.privatebrowsing.forceMediaMemoryCache" = lock-true;
      "browser.sessionstore.interval" = 60000;

      # Shutdown & Sanitizing
      "browser.privatebrowsing.resetPBM.enabled" = lock-true;
      "privacy.history.custom" = lock-true;

      # Search / URL Bar
      "browser.urlbar.trimHttps" = lock-true;
      "browser.urlbar.untrimOnUserInteraction.featureGate" = lock-true;
      "browser.search.separatePrivateDefault.ui.enabled" = lock-true;
      "browser.urlbar.update2.engineAliasRefresh" = lock-true;
      "browser.search.suggest.enabled" = lock-false;
      "browser.urlbar.quicksuggest.enabled" = lock-false;
      "browser.urlbar.groupLabels.enabled" = lock-false;
      "browser.formfill.enable" = lock-false;
      "security.insecure_connection_text.enabled" = lock-true;
      "security.insecure_connection_text.pbmode.enabled" = lock-true;
      "network.IDN_show_punycode" = lock-true;

      # HTTPS First Security
      "dom.security.https_first" = lock-true;

      # Passwords
      "signon.formlessCapture.enabled" = lock-false;
      "signon.privateBrowsingCapture.enabled" = lock-false;
      "network.auth.subresource-http-auth-allow" = 1;
      "editor.truncate_user_pastes" = lock-false;

      # Mixed Contents + Cross Site
      "security.mixed_content.block_display_content" = lock-true;
      "pdfjs.enableScripting" = lock-false;

      # Extensions
      "extensions.enabledScopes" = 5;

      # Headers / Referers
      "network.http.referer.XOriginTrimmingPolicy" = 2;

      # Containers
      "privacy.userContext.ui.enabled" = lock-true;

      # Safe Browsing
      "browser.safebrowsing.downloads.remote.enabled" = lock-false;

      # Mozilla
      "permissions.default.desktop-notification" = 2;
      "permissions.default.geo" = 2;
      "browser.search.update" = lock-false;
      "permissions.manager.defaultsUrl" = lock-empty-string;

      # Telemetry
      "datareporting.policy.dataSubmissionEnabled" = lock-false;
      "datareporting.healthreport.uploadEnabled" = lock-false;
      "toolkit.telemetry.unified" = lock-false;
      "toolkit.telemetry.enabled" = lock-false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.archive.enabled" = lock-false;
      "toolkit.telemetry.newProfilePing.enabled" = lock-false;
      "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
      "toolkit.telemetry.updatePing.enabled" = lock-false;
      "toolkit.telemetry.bhrPing.enabled" = lock-false;
      "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
      "toolkit.telemetry.coverage.opt-out" = lock-true;
      "toolkit.coverage.opt-out" = lock-true;
      "toolkit.coverage.endpoint.base" = lock-empty-string;
      "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
      "browser.newtabpage.activity-stream.telemetry" = lock-false;

      # Experiments
      "app.shield.optoutstudies.enabled" = lock-false;
      "app.normandy.enabled" = lock-false;
      "app.normandy.api_url" = lock-empty-string;

      # Crash Reports
      "breakpad.reportURL" = lock-empty-string;
      "browser.tabs.crashReporting.sendReport" = lock-false;

      # Detection
      "captivedetect.canonicalURL" = lock-empty-string;
      "network.captive-portal-service.enabled" = lock-false;
      "network.connectivity-service.enabled" = lock-false;

      # Mozilla UI
      "browser.privatebrowsing.vpnpromourl" = lock-empty-string;
      "extensions.getAddons.showPane" = lock-false;
      "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
      "browser.discovery.enabled" = lock-false;
      "browser.shell.checkDefaultBrowser" = lock-false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = lock-false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = lock-false;
      "browser.preferences.moreFromMozilla" = lock-false;
      "browser.aboutConfig.showWarning" = lock-false;
      "browser.aboutwelcome.enabled" = lock-false;
      "browser.profiles.enabled" = lock-true;

      # Theme Adjustment
      "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
      "browser.compactmode.show" = lock-true;
      "browser.privateWindowSeparation.enabled" = lock-false;

      # Cookie Banner Handling
      "cookiebanners.service.mode" = 1;
      "cookiebanners.service.mode.privateBrowsing" = 1;

      # Fullscreen Notice
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.timeout" = 0;

      # URL Bar
      "browser.urlbar.suggest.calculator" = lock-true;
      "browser.urlbar.unitConversion.enabled" = lock-true;
      "browser.urlbar.trending.featureGate" = lock-false;

      # New Tab Page
      "browser.newtabpage.activity-stream.feeds.topsites" = lock-false;
      "browser.newtabpage.activity-stream.showWeather" = lock-false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;

      # Pocket
      "extensions.pocket.enabled" = lock-false;

      # Downloads
      "browser.download.manager.addToRecentDocs" = lock-false;

      # Pdf
      "browser.download.open_pdf_attachments_inline" = lock-true;

      # Tab Behavior
      "browser.bookmarks.openInTabClosesMenu" = lock-false;
      "browser.menu.showViewImageInfo" = lock-true;
      "findbar.highlightAll" = lock-true;
      "layout.word_select.eat_space_to_next_word" = lock-false;
    };
  };
}
