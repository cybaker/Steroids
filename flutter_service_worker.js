'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"index.html": "4a689336df80a6fc4ac6a3b851664d23",
"/": "4a689336df80a6fc4ac6a3b851664d23",
"main.dart.js": "014e3332045c98755811e6cbef8c7319",
"manifest.json": "926b801a1b7c7988b1220759decf0454",
"favicon.png": "c113cbd9ff7f512a36079b9ab4487569",
"icons/Icon-512.png": "778b7c6f1cef4f5a077f09ab01bccce8",
"icons/Icon-maskable-512.png": "778b7c6f1cef4f5a077f09ab01bccce8",
"icons/favicon.png": "fa7fde306a35e196516bf8b1d6100f14",
"icons/Icon-maskable-192.png": "e178f53367e1179d3005e51c5675134d",
"icons/Icon-192.png": "e178f53367e1179d3005e51c5675134d",
"assets/FontManifest.json": "1fa8cf02fdf641ef4fe43dca705c2fee",
"assets/NOTICES": "2858b9d771fedb104ef8610bf4f2a67f",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/stars2.png": "b7bc0d6b8e94cdf1a05c1a9e0a28a229",
"assets/assets/images/nuke.png": "62ef17c3cee341df67f647d0b103d430",
"assets/assets/images/enemy_D.png": "57860e8667674a821498fcd5f8edefb4",
"assets/assets/images/station_B.png": "ecc8d155c0b63e4bcc0f40f4020e33e4",
"assets/assets/images/stars1.png": "c25761cd6cade2f6dde20d36fde8218c",
"assets/assets/images/skull.png": "59f2c9eadbe0ceb55581f768a5e4c603",
"assets/assets/images/README.md": "562f082fb824afec8dc34a9fa3ddd08d",
"assets/assets/images/ship_A.png": "8287a1d334b47beb530072d96070e23e",
"assets/assets/images/multi_fire.png": "252ed5eb339c68c5fd6079c94622b743",
"assets/assets/sfx/beat2.wav": "a02b010d6b4e8c448d4119c8ffc67dd4",
"assets/assets/sfx/beat1.wav": "a014226b4105c0a7707a408c2fa265df",
"assets/assets/sfx/saucerBig.wav": "51000f5c0843dc7080ec44941adf6fde",
"assets/assets/sfx/extraShip.wav": "5eb474ea2cc6224a57fb5da1f133b1ff",
"assets/assets/sfx/saucerSmall.wav": "b5e70346fd5d7b48481fe3c74d0dc11d",
"assets/assets/sfx/fire.wav": "c4dc2846cda7be9584144a0366c2a66b",
"assets/assets/sfx/bangLarge.wav": "23e343a239da9dd38ca22e6bea07fc3d",
"assets/assets/sfx/bangMedium.wav": "0caca04fc706b763596358b416649732",
"assets/assets/sfx/bangSmall.wav": "1bf00be1716e8fe24a40ebd570058ae3",
"assets/assets/sfx/thrust.wav": "1a67a2d9c6fe3b03124c392f37aba2f3",
"assets/assets/audio/beat2.wav": "a02b010d6b4e8c448d4119c8ffc67dd4",
"assets/assets/audio/beat1.wav": "a014226b4105c0a7707a408c2fa265df",
"assets/assets/audio/saucerBig.wav": "51000f5c0843dc7080ec44941adf6fde",
"assets/assets/audio/extraShip.wav": "5eb474ea2cc6224a57fb5da1f133b1ff",
"assets/assets/audio/saucerSmall.wav": "b5e70346fd5d7b48481fe3c74d0dc11d",
"assets/assets/audio/fire.wav": "c4dc2846cda7be9584144a0366c2a66b",
"assets/assets/audio/bangLarge.wav": "23e343a239da9dd38ca22e6bea07fc3d",
"assets/assets/audio/bangMedium.wav": "0caca04fc706b763596358b416649732",
"assets/assets/audio/bangSmall.wav": "1bf00be1716e8fe24a40ebd570058ae3",
"assets/assets/audio/thrust.wav": "1a67a2d9c6fe3b03124c392f37aba2f3",
"assets/assets/AstroSpace/AstroSpace-eZ2Bg.ttf": "5892adccd6c4b8c9e80f005e7eef06f2",
"assets/assets/music/README.md": "c8f12955cd053c304b6ad0cf1b3a3056",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/AssetManifest.json": "5678e9866d87ac46d9f55fb66b53192a",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"version.json": "a804f34997adb7309b9d59adc5f6d3b7"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
