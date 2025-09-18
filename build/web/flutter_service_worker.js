'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "7260fecaf796c3539a2dc830019857b6",
"assets/AssetManifest.bin.json": "29ab5153adfa4e252263304cd91ab2bc",
"assets/AssetManifest.json": "02db91fc96a2a97a2744b59c3691938d",
"assets/assets/angular.png": "3ed91427828c7b282e4926da2423b8d6",
"assets/assets/apk/ramchinsmartschool.apk": "791a2e58675abe64aa5a1dc182224d98",
"assets/assets/apk/ramchin_smart_school.apk": "589b62f65c91eea90aaf1f305866c616",
"assets/assets/Brochure.pdf": "5daaf7507daad629a46b27458eca4503",
"assets/assets/compress/14-min.jpeg": "fb378684d619d1162c3385090914c94e",
"assets/assets/compress/16-min.jpeg": "75c8ef979c25c384bdd0e6f26e2278c7",
"assets/assets/compress/18-min.jpeg": "53a895429c4a36add83d3bd7f62f90d7",
"assets/assets/compress/2-min.jpeg": "b9d971d056e473a965e1854321804e09",
"assets/assets/compress/37-min.jpeg": "8318f38351d444c8eabf87f5590d8aab",
"assets/assets/compress/5-min.jpeg": "ed92538a6ba96c92f93798cd6b0bc32b",
"assets/assets/compress/69-min_11zon.png": "74b99c3c7a251183cdbfad3eba216e89",
"assets/assets/compress/70-min_11zon.png": "66e15e30ede1ebb1064f622522bdae5f",
"assets/assets/compress/75-min.jpeg": "fc3e56108ab86bfbb809a7717eb60cbd",
"assets/assets/compress/77-min.jpeg": "35a8070a58173c19f0f2381bb74cffc7",
"assets/assets/compress/79-min.jpeg": "2dfb68e451eb8edc73162c8eabd4091e",
"assets/assets/compress/9-min.jpeg": "eacea06223768aaaf9e9eafd2c636828",
"assets/assets/compress/DSC_2507-min.jpeg": "f556679b5170672481964c14c4535547",
"assets/assets/compress/DSC_2507-min.webp": "4f39b50fea8f44185fdc09a8acf146b0",
"assets/assets/compress/DSC_2513-min.jpeg": "7939c92d63c71adef0348e791344f9d1",
"assets/assets/compress/DSC_2521-min.jpeg": "17e0a5241595d10a56d8865b3ff1d4c4",
"assets/assets/compress/DSC_2535-min.jpeg": "a2d8027871bcf8e5744d2e9233d9dd65",
"assets/assets/compress/DSC_2538-min.jpeg": "fafb744449869607dec39bc49f8f57bb",
"assets/assets/compress/DSC_2543-min.jpeg": "d8ae61b089d8451f36c64cafe4ff05c8",
"assets/assets/compress/DSC_2543-min.webp": "04f26db392b62e19a9cb4eb4e4ac57db",
"assets/assets/compress/DSC_2547-min.jpeg": "951681e9b4889da28363b03abf58734c",
"assets/assets/compress/DSC_2561-min.jpeg": "ed2ddd22db05b9a7847786de8d2d899e",
"assets/assets/compress/DSC_2566-min.jpeg": "e3f1fa993c883ebbf35bba6406e0943d",
"assets/assets/compress/DSC_2566-min.webp": "9a122b2037311bb07b7000e61b3fa4a1",
"assets/assets/compress/DSC_2578-min.jpeg": "9f2aa57ff862b0b3359672bb14d461bc",
"assets/assets/compress/DSC_2578-min.webp": "846db90226f1e4477ee03c871e532b12",
"assets/assets/compress/DSC_2584-min.jpeg": "0410b11640fe9f2645fd68138069476d",
"assets/assets/compress/DSC_2593.jpeg": "612983876edf1d547276c8225159fee4",
"assets/assets/compress/g01.jpeg": "0998edbf44051b833c8a35cec3edde64",
"assets/assets/compress/g02.jpeg": "950aec9c92edcaf6e4856a28d4771f5e",
"assets/assets/compress/g03.jpeg": "a47f6e9347a5efbdc395a8547ee87901",
"assets/assets/compress/g04.jpeg": "95341f097df26eadb12d986bfe0c4c57",
"assets/assets/cvsir2.jpg": "2f295ca41a7fd668a915a6124e22f74b",
"assets/assets/dotNET.png": "8dc00d34d2ddd8602a0ccb4c8405e906",
"assets/assets/drcv.pdf": "33f7c7bdbd9707c55772bd8174f8c3fb",
"assets/assets/DSC_2584.png.crdownload": "a4852221e46bf8df76b7d22ee3a072c0",
"assets/assets/Express.png": "da2567a73dfe0c265b05aec9259d00b2",
"assets/assets/flutter.png": "13e9c72ec37fac220397aa819fa1ef2d",
"assets/assets/flutter1.png": "72000f8f3804cc4c4248eeb40b6ada40",
"assets/assets/ic_launcher.jpg": "53d5d3ebfc07b4c90567f9f9033bb1e6",
"assets/assets/image1.png": "bfa31560654bb064281dd017c2130e1d",
"assets/assets/image2.png": "290f312fea05709119cdeabd3751259a",
"assets/assets/image3.jpeg": "510028477f0ed7b6092b5172c897079a",
"assets/assets/Logo.png": "ef0a2beee826b8b917961179024d96c4",
"assets/assets/loogo.jpg": "17c2996df723a57b9777a6159c308329",
"assets/assets/loogo1.png": "9de2153d60f2654b0e8ad47331ecec4a",
"assets/assets/member/bala.jpg": "30dea35475d2514c5aa2d2f16ce55774",
"assets/assets/member/brightlin.jpeg": "a4bec11e06789054e2a6abcad692b758",
"assets/assets/member/dharsha.jpeg": "3bddb3ef3850a9e8b49ba2f1f11b300f",
"assets/assets/member/essakkiyammal.jpg": "f37b82b06951a3a5364ab321a30dc39f",
"assets/assets/member/gopi.jpeg": "f112f945be7d9bc1a4139a8c33abc34f",
"assets/assets/member/lakshmi.jpeg": "6ec3787d2877cb8cc199b1f81224c174",
"assets/assets/member/murali.jpeg": "5c24a87a7ed888011a6246eafb11933a",
"assets/assets/member/parthi.jpg": "c474ac35af9417374375f683d7adc208",
"assets/assets/member/pooja.jpg": "97db32a8c620a721e0dc8ae935c658a6",
"assets/assets/member/ramu.jpeg": "63e839d82889d9be736ca4c85e8936b8",
"assets/assets/member/shivani.jpeg": "2acbb451de72c74ae87f00879759b5cc",
"assets/assets/member/sowmiya.jpeg": "395322db07baa9cc7e35a1a46efa54cf",
"assets/assets/member/swarlin.jpeg": "48d9ff7f54d24b544c30660751adb629",
"assets/assets/member/yoga.jpeg": "b525f4108fd5229aca67014f2594a0a1",
"assets/assets/mong.png": "797cb351b1b34e7541883f57cb1c89e8",
"assets/assets/mongodb.png": "310f1c87c763727d098f093bcc969a5d",
"assets/assets/mozhi2.png": "61a42850fa7ec039d88c4b186bb05726",
"assets/assets/mysql2.png": "d8e78a7d055e0097df74ff185c1a2078",
"assets/assets/mysql21.png": "30ea64f9aa8ca1d386bda903ec48b4b3",
"assets/assets/nextjs.png": "8ab094bf98ea172461c99d151de01793",
"assets/assets/node.png": "9a1814348ebc9603894b4f9eb5fbf28f",
"assets/assets/node1.png": "a888e3fbc1c98a140fdd97c3d6052dec",
"assets/assets/OIP.png": "74094f4dafda6d121aa370ada2fc5627",
"assets/assets/part1.jpg": "172bd43659729c9972d845fb54901110",
"assets/assets/php.png": "33c6dd30823ec4bf789518e65bec2e8c",
"assets/assets/png/14.jpeg": "b61fd04f73fa3b055fa5c8e43f14688b",
"assets/assets/png/16.jpeg": "d1de8de7873b3c43c2a8bc73d3cc4b97",
"assets/assets/png/18.jpeg": "8dc0239aa7b861de45d250442398552b",
"assets/assets/png/2.jpeg": "8fff5ab5ccb8bb03e87433e29166fc30",
"assets/assets/png/37.jpeg": "e6f3e1cafa897090cd8568367f9a5244",
"assets/assets/png/5.jpeg": "6532cacccb99b0e4e2cef8075bb1416b",
"assets/assets/png/75.jpeg": "2a1fd083c344bdbc94dcdcb27d927604",
"assets/assets/png/77.jpeg": "d7a8a62b89744209b2820a5b19b591ca",
"assets/assets/png/79.jpeg": "d8c1a1e6fcbd5425e88f9f1834150021",
"assets/assets/png/9.jpeg": "1ed908b2f82d8f598da2da09d595e42b",
"assets/assets/png/DSC_2507.jpeg": "97f2455ca3ec6796b0c35ddbf451051c",
"assets/assets/png/DSC_2513.jpeg": "dbb1c609d23e140c2b3aba5b38812de2",
"assets/assets/png/DSC_2521.jpeg": "339bf085afbd2f9aa897766391f4630e",
"assets/assets/png/DSC_2535.jpeg": "655b099829bf2507bf56e6f45efa44d1",
"assets/assets/png/DSC_2538.jpeg": "b3a0ba246764db8305da9f573218ea18",
"assets/assets/png/DSC_2543.jpeg": "55e771af1bd85559759b46e9cfa01ff6",
"assets/assets/png/DSC_2547.jpeg": "594c4f26a630c3294fe85f0643e645c9",
"assets/assets/png/DSC_2561.jpeg": "87c98fa28b1478b51488e769dc315c72",
"assets/assets/png/DSC_2566.jpeg": "0aacfae1e2acd5a3a797e3243d6840be",
"assets/assets/png/DSC_2578.jpeg": "ca25dc688a85aa758a379c8c6287e593",
"assets/assets/png/DSC_2584.jpeg": "67f6078f1b03b7eab504d311e2c8bbfe",
"assets/assets/png/DSC_2593.jpeg": "612983876edf1d547276c8225159fee4",
"assets/assets/png/g03.jpeg": "a47f6e9347a5efbdc395a8547ee87901",
"assets/assets/png/g04.jpeg": "95341f097df26eadb12d986bfe0c4c57",
"assets/assets/png/screen3.png": "c6401c794d765065ad023c6a60e56b0b",
"assets/assets/ramchinlogo.png": "28bfd6bd76b4c26ac348d6c93a0f3399",
"assets/assets/ramchinlogoB.png": "106422390acfddff7553a419b1fb181f",
"assets/assets/react.png": "b7c0a91cec1611d45d2be27bb2883cc1",
"assets/assets/react1.png": "63dbda326acdcbb06bced8c346f257d9",
"assets/assets/SarPhoto.png": "a262a5a6c34cca28a3e420724697e4eb",
"assets/assets/screen1.png": "85e01eef5fb7ddd8b879b648f568b08b",
"assets/assets/screen2.png": "42b9028af04653a3b9943b35c0ce3fd4",
"assets/assets/screen3.png": "c6401c794d765065ad023c6a60e56b0b",
"assets/assets/screenV.mp4": "f56f01720919d881dda7391f3bc65f26",
"assets/assets/SenPhoto3.jpg": "5485496fdd2991ef38e74ce3c7c68e9d",
"assets/assets/ss30.jpg": "127dd8f41e37a6c9543e3329ad81a44f",
"assets/FontManifest.json": "3fedc2fda7b468c4a07a99e7c0cfe2cc",
"assets/fonts/MaterialIcons-Regular.otf": "05e675c1f0d4825d7382627db1946276",
"assets/NOTICES": "394cb13bfcd40bbb83cd42153ad23dff",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "89b7118e5df0214e0fc8f3a128ae3a2b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "4b7df17f0da95d21854232a4f2bc0742",
"assets/packages/simple_icons/fonts/SimpleIcons.ttf": "90580190a5349ea2d3a73ccca4c41e4a",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "819c148e961aa7baa76dcfb3e2b125bf",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d723844a0f4592a4a0c12b2d0922b849",
"/": "d723844a0f4592a4a0c12b2d0922b849",
"main.dart.js": "7c3f9577c0c0f9ddd0fd37bc735cfb6c",
"manifest.json": "45d2c5185774a8302e75eadf5b415de0",
"version.json": "6f8798068fec6c022f351ed1cc123762"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
