from netbox.settings import *

try:
    MIDDLEWARE = MIDDLEWARE
except:
    MIDDLEWARE = ()
MIDDLEWARE = ('whitenoise.middleware.WhiteNoiseMiddleware',*MIDDLEWARE)

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
