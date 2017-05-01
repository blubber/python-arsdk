cdef extern from "libARDiscovery/ARDISCOVERY_Error.h":
    ctypedef enum eARDISCOVERY_ERROR:
        ARDISCOVERY_OK,
        ARDISCOVERY_ERROR,

        ARDISCOVERY_ERROR_SIMPLE_POLL,
        ARDISCOVERY_ERROR_BUILD_NAME,
        ARDISCOVERY_ERROR_CLIENT,
        ARDISCOVERY_ERROR_CREATE_CONFIG,
        ARDISCOVERY_ERROR_DELETE_CONFIG,
        ARDISCOVERY_ERROR_ENTRY_GROUP,
        ARDISCOVERY_ERROR_ADD_SERVICE,
        ARDISCOVERY_ERROR_GROUP_COMMIT,
        ARDISCOVERY_ERROR_BROWSER_ALLOC,
        ARDISCOVERY_ERROR_BROWSER_NEW,

        ARDISCOVERY_ERROR_ALLOC,
        ARDISCOVERY_ERROR_INIT,
        ARDISCOVERY_ERROR_SOCKET_CREATION,
        ARDISCOVERY_ERROR_SOCKET_PERMISSION_DENIED,
        ARDISCOVERY_ERROR_SOCKET_ALREADY_CONNECTED,
        ARDISCOVERY_ERROR_ACCEPT,
        ARDISCOVERY_ERROR_SEND,
        ARDISCOVERY_ERROR_READ,
        ARDISCOVERY_ERROR_SELECT,
        ARDISCOVERY_ERROR_TIMEOUT,
        ARDISCOVERY_ERROR_ABORT,
        ARDISCOVERY_ERROR_PIPE_INIT,
        ARDISCOVERY_ERROR_BAD_PARAMETER,
        ARDISCOVERY_ERROR_BUSY,
        ARDISCOVERY_ERROR_SOCKET_UNREACHABLE,
        ARDISCOVERY_ERROR_OUTPUT_LENGTH,

        ARDISCOVERY_ERROR_JNI,
        ARDISCOVERY_ERROR_JNI_VM,
        ARDISCOVERY_ERROR_JNI_ENV,
        ARDISCOVERY_ERROR_JNI_CALLBACK_LISTENER,

        ARDISCOVERY_ERROR_CONNECTION,
        ARDISCOVERY_ERROR_CONNECTION_BUSY,
        ARDISCOVERY_ERROR_CONNECTION_NOT_READY,
        ARDISCOVERY_ERROR_CONNECTION_BAD_ID,

        ARDISCOVERY_ERROR_DEVICE,
        ARDISCOVERY_ERROR_DEVICE_OPERATION_NOT_SUPPORTED,

        ARDISCOVERY_ERROR_JSON,
        ARDISCOVERY_ERROR_JSON_PARSSING,
        ARDISCOVERY_ERROR_JSON_BUFFER_SIZE


cdef extern from "libARDiscovery/ARDISCOVERY_Discovery.h":
    ctypedef enum eARDISCOVERY_PRODUCT:
       ARDISCOVERY_PRODUCT_ARDRONE


cdef extern from "libARDiscovery/ARDISCOVERY_Device.h":
    ctypedef struct ARDISCOVERY_Device_t:
        pass


    ARDISCOVERY_Device_t *ARDISCOVERY_Device_New(eARDISCOVERY_ERROR *error)
    eARDISCOVERY_ERROR ARDISCOVERY_Device_InitWifi(ARDISCOVERY_Device_t *device,
                                                   eARDISCOVERY_PRODUCT product,
                                                   const char *name,
                                                   const char *address,
                                                   int discovery_port)
