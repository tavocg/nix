{ lib, ... }:
let
  # Interface languages. Costa Rica has no dedicated pack, so es-MX is the
  # closest Latin American Spanish variant.
  languagePacks = [
    "en-US"
    "es-MX"
  ];

  # --------------------------------------------------------------------------
  # about:config preferences.
  #
  # Used as `programs.firefox.preferences` by the NixOS module (emitted through
  # the enterprise "Preferences" policy) and as the same "Preferences" policy by
  # the standalone `.#firefox` package. With the default
  # `preferencesStatus = "locked"` they show up as defaults and cannot be
  # changed from the UI.
  # --------------------------------------------------------------------------
  preferences = {
    # ---- Content / tracking protection ----
    "browser.contentblocking.category" = "strict";
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.pbmode.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;
    "privacy.trackingprotection.cryptomining.enabled" = true;
    "privacy.trackingprotection.fingerprinting.enabled" = true;
    "privacy.trackingprotection.emailtracking.enabled" = true;
    "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.enabled" = true;
    "privacy.globalprivacycontrol.functionality.enabled" = true;

    # ---- Fingerprint resistance ----
    # Strong hardening; a few sites (canvas, timezone, screen size) may
    # behave differently.
    "privacy.resistFingerprinting" = true;
    "privacy.resistFingerprinting.pbmode" = true;

    # ---- Telemetry / studies / crash reports ----
    "app.shield.optoutstudies.enabled" = false;
    "app.normandy.enabled" = false;
    "app.normandy.api_url" = "";
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.updatePing.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.coverage.opt-out" = true;
    "toolkit.coverage.opt-out" = true;
    "toolkit.coverage.endpoint.base" = "";
    "browser.ping-centre.telemetry" = false;
    "browser.discovery.enabled" = false;
    "browser.tabs.crashReporting.sendReport" = false;
    "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
    "breakpad.reportURL" = "";

    # ---- Search / address bar suggestions ----
    "browser.search.suggest.enabled" = false;
    "browser.search.suggest.enabled.private" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.showSearchSuggestionsFirst" = false;
    "browser.urlbar.quicksuggest.enabled" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;

    # ---- New tab page / sponsored content ----
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.snippets" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.system.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
    "browser.topsites.contile.enabled" = false;

    # ---- Pocket / screenshots / accounts ----
    "extensions.pocket.enabled" = false;
    "extensions.screenshots.disabled" = true;
    "identity.fxaccounts.enabled" = false;

    # ---- Forms / passwords / autofill ----
    "browser.formfill.enable" = false;
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;
    "signon.rememberSignons" = false;
    "signon.autofillForms" = false;
    "signon.generation.enabled" = false;
    "signon.management.page.breach-alerts.enabled" = false;

    # ---- Add-on recommendations / tours ----
    "extensions.getAddons.showPane" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "extensions.recommendations.themeRecommendationUrl" = "";
    "browser.uitour.enabled" = false;

    # ---- Network hardening ----
    "network.dns.disablePrefetch" = true;
    "network.dns.disablePrefetchFromHTTPS" = true;
    "network.prefetch-next" = false;
    "network.predictor.enabled" = false;
    "network.predictor.enable-prefetch" = false;
    "network.http.speculative-parallel-limit" = 0;
    "network.captive-portal-service.enabled" = false;
    "network.connectivity-service.enabled" = false;
    "network.http.referer.XOriginPolicy" = 2;
    "network.http.referer.XOriginTrimmingPolicy" = 2;
    "network.IDN_show_punycode" = true;

    # ---- Misc privacy / security ----
    "beacon.enabled" = false;
    "browser.send_pings" = false;
    "browser.send_pings.require_same_host" = true;
    "dom.battery.enabled" = false;
    "device.sensors.enabled" = false;
    "dom.event.clipboardevents.enabled" = false;
    "geo.enabled" = false;
    "media.peerconnection.ice.default_address_only" = true;
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_ever_enabled" = true;
    "dom.security.https_only_mode_pbm" = true;
    "pdfjs.enableScripting" = false;
    "security.cert_pinning.enforcement_level" = 2;
    "browser.safebrowsing.downloads.remote.enabled" = false;

    # ---- Containers ----
    "privacy.userContext.enabled" = true;
    "privacy.userContext.ui.enabled" = true;

    # ---- Toolbar layout / density ----
    # Compact density (0 = normal, 1 = compact, 2 = touch).
    "browser.uidensity" = 1;

    # Start from Firefox's default nav-bar, minus the sidebar button. We keep
    # the new sidebar (`sidebar.revamp` stays enabled) but drop its toolbar
    # button, which otherwise has no dedicated pref to hide it.
    "browser.uiCustomization.state" = builtins.toJSON {
      placements."nav-bar" = [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "spring"
        "vertical-spacer"
        "urlbar-container"
        "spring"
        "downloads-button"
        "fxa-toolbar-menu-button"
      ];
      currentVersion = 28;
    };
    # Marks the sidebar button as already introduced so Firefox does not
    # re-inject it into the nav-bar on startup.
    "browser.toolbarbuttons.introduced.sidebar-button" = true;
  };

  # --------------------------------------------------------------------------
  # Enterprise policies (about:policies#documentation) shared by the module and
  # the package. `ExtensionSettings` is kept out so each output can extend it.
  # --------------------------------------------------------------------------
  basePolicies = {
    # ---- Telemetry / accounts / feedback ----
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisableFeedbackCommands = true;
    DisablePocket = true;
    DisableFirefoxAccounts = true;
    DisableAccounts = true;
    DisableFirefoxScreenshots = true;
    DisableProfileImport = true;
    DisableProfileRefresh = true;
    DontCheckDefaultBrowser = true;

    # ---- Password manager ----
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    PasswordManagerAllowShowPasswords = false;

    # ---- Tracking protection ----
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
    };
    NetworkPrediction = false;

    # ---- UI ----
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";
    DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
    DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
    SearchBar = "unified"; # alternative: "separate"

    # ---- Search ----
    SearchEngines = {
      Default = "DuckDuckGo";
    };

    # ---- New tab page ----
    FirefoxHome = {
      Search = false;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
      Locked = true;
    };

    # ---- Onboarding / recommendations ----
    UserMessaging = {
      ExtensionRecommendations = false;
      FeatureRecommendations = false;
      UrlbarInterventions = false;
      MoreFromMozilla = false;
      FirefoxLabs = false;
      SkipOnboarding = true;
      Locked = true;
    };

    # ---- Default site permissions ----
    Permissions = {
      Camera = {
        BlockNewRequests = true;
        Locked = true;
      };
      Microphone = {
        BlockNewRequests = true;
        Locked = true;
      };
      Location = {
        BlockNewRequests = true;
        Locked = true;
      };
      Notifications = {
        BlockNewRequests = true;
        Locked = true;
      };
      VirtualReality = {
        BlockNewRequests = true;
        Locked = true;
      };
      Autoplay = {
        Default = "block-audio-video";
        Locked = true;
      };
    };
  };

  # Extensions installed and locked down. "*" blocks every other add-on.
  extensionSettings = {
    "*".installation_mode = "blocked";

    # uBlock Origin
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      # The add-on asks for the toolbar; keep it in the extensions panel.
      default_area = "menupanel";
    };

    # Privacy Badger
    "jid1-MnnxcxisBPnSXQ@jetpack" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
      default_area = "menupanel";
    };

    # Dark Reader
    "addon@darkreader.org" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    };
  };

  preferencesPolicy = lib.mapAttrs (_: value: {
    Value = value;
    Status = "locked";
  }) preferences;
in
{
  # NixOS module: policies are installed to /etc/firefox/policies/policies.json
  # and preferences through the module's own "Preferences" policy.
  flake.nixosModules.packagesGUIFirefox =
    { config, lib, ... }:
    let
      x11Enabled = config.local.x11.enable;
      waylandEnabled = config.local.wayland.enable;
      windowingEnabled = x11Enabled || waylandEnabled;
    in
    {
      config = lib.mkIf windowingEnabled {
        programs.firefox = {
          enable = true;
          inherit languagePacks preferences;
          policies = basePolicies // {
            ExtensionSettings = extensionSettings;
          };
        };
      };
    };

  # Standalone package: `nix profile add .#firefox` (or `nix build .#firefox`).
  # The same policies, preferences and extensions are baked into the browser
  # instead of being read from /etc.
  perSystem =
    { pkgs, lib, ... }:
    let
      mozPlatform =
        {
          x86_64-linux = "linux-x86_64";
          aarch64-linux = "linux-aarch64";
        }
        .${pkgs.stdenv.hostPlatform.system} or null;

      langpackSettings = lib.optionalAttrs (mozPlatform != null) (
        builtins.listToAttrs (
          map (lang: lib.nameValuePair "langpack-${lang}@firefox.mozilla.org" {
            installation_mode = "normal_installed";
            install_url = "https://releases.mozilla.org/pub/firefox/releases/${pkgs.firefox.version}/${mozPlatform}/xpi/${lang}.xpi";
          }) languagePacks
        )
      );
    in
    {
      packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        firefox = pkgs.firefox.override {
          extraPolicies = basePolicies // {
            # The nixpkgs NixOS module sets this; mirror it for the package.
            DisableAppUpdate = true;
            Preferences = preferencesPolicy;
            ExtensionSettings = extensionSettings // langpackSettings;
          };
        };
      };
    };
}
