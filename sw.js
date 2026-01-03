// Service Worker for DevOps Portfolio PWA
const CACHE_NAME = 'devops-portfolio-v1.0.0';
const STATIC_CACHE = 'static-v1';
const DYNAMIC_CACHE = 'dynamic-v1';

// Resources to cache immediately
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/about-me.html',
  '/skills.html', 
  '/projects.html',
  '/contact.html',
  '/style.css',
  '/global-sidebar.js',
  '/manifest.json',
  '/images/profile-optimized.jpg',
  '/images/banner-optimized.jpg',
  '/favicon.ico'
];

// Resources to cache on first visit
const DYNAMIC_ASSETS = [
  '/project-ultimate-devops-container.html',
  '/project-ecommerce-platform.html',
  '/project-enterprise-cicd.html',
  '/aws-solutions.html',
  '/azure-solutions.html',
  '/gcp-solutions.html'
];

// Install event - cache static assets
self.addEventListener('install', event => {
  console.log('🔧 Service Worker: Installing...');
  
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(cache => {
        console.log('📦 Service Worker: Caching static assets');
        return cache.addAll(STATIC_ASSETS);
      })
      .then(() => {
        console.log('✅ Service Worker: Static assets cached');
        return self.skipWaiting();
      })
      .catch(error => {
        console.error('❌ Service Worker: Cache failed', error);
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  console.log('🚀 Service Worker: Activating...');
  
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames
            .filter(cacheName => {
              return cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE;
            })
            .map(cacheName => {
              console.log('🗑️ Service Worker: Deleting old cache', cacheName);
              return caches.delete(cacheName);
            })
        );
      })
      .then(() => {
        console.log('✅ Service Worker: Activated');
        return self.clients.claim();
      })
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);
  
  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }
  
  // Skip external requests
  if (url.origin !== location.origin) {
    return;
  }
  
  event.respondWith(
    caches.match(request)
      .then(cachedResponse => {
        if (cachedResponse) {
          console.log('📦 Service Worker: Serving from cache', request.url);
          return cachedResponse;
        }
        
        console.log('🌐 Service Worker: Fetching from network', request.url);
        return fetch(request)
          .then(networkResponse => {
            // Don't cache if not a success response
            if (!networkResponse || networkResponse.status !== 200 || networkResponse.type !== 'basic') {
              return networkResponse;
            }
            
            // Clone response for caching
            const responseToCache = networkResponse.clone();
            
            // Cache dynamic assets
            caches.open(DYNAMIC_CACHE)
              .then(cache => {
                console.log('📦 Service Worker: Caching dynamic asset', request.url);
                cache.put(request, responseToCache);
              });
            
            return networkResponse;
          })
          .catch(error => {
            console.error('❌ Service Worker: Network fetch failed', error);
            
            // Return offline page for HTML requests
            if (request.destination === 'document') {
              return caches.match('/offline.html');
            }
            
            // Return placeholder for images
            if (request.destination === 'image') {
              return caches.match('/images/offline-placeholder.svg');
            }
            
            throw error;
          });
      })
  );
});

// Background sync for contact form
self.addEventListener('sync', event => {
  if (event.tag === 'contact-form-sync') {
    console.log('🔄 Service Worker: Syncing contact form data');
    event.waitUntil(syncContactForm());
  }
});

// Push notifications (for future use)
self.addEventListener('push', event => {
  console.log('📬 Service Worker: Push notification received');
  
  const options = {
    body: event.data ? event.data.text() : 'New update available!',
    icon: '/images/android-chrome-192x192.png',
    badge: '/images/badge-72x72.png',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      {
        action: 'explore',
        title: 'View Portfolio',
        icon: '/images/action-explore.png'
      },
      {
        action: 'close',
        title: 'Close',
        icon: '/images/action-close.png'
      }
    ]
  };
  
  event.waitUntil(
    self.registration.showNotification('DevOps Portfolio', options)
  );
});

// Notification click handler
self.addEventListener('notificationclick', event => {
  console.log('🔔 Service Worker: Notification clicked');
  
  event.notification.close();
  
  event.waitUntil(
    clients.openWindow('/')
  );
});

// Helper function for contact form sync
async function syncContactForm() {
  try {
    // Get pending form data from IndexedDB
    const formData = await getStoredFormData();
    
    if (formData) {
      // Send to backend when online
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
      });
      
      if (response.ok) {
        // Clear stored data on success
        await clearStoredFormData();
        console.log('✅ Service Worker: Contact form synced successfully');
      }
    }
  } catch (error) {
    console.error('❌ Service Worker: Contact form sync failed', error);
  }
}

// IndexedDB helpers (simplified)
async function getStoredFormData() {
  // Implementation for retrieving form data from IndexedDB
  return null; // Placeholder
}

async function clearStoredFormData() {
  // Implementation for clearing form data from IndexedDB
}