from enum import Enum

from libardiscovery cimport *
from libarcontroller cimport *

class Error(Exception):
    def __init__(self, code):
        super().__init__(self.Error(code))


class ARDiscoveryError(Error):
    class Error(Enum):
        OK = ARDISCOVERY_OK
        ERROR = ARDISCOVERY_ERROR

        SIMPLE_POLL = ARDISCOVERY_ERROR_SIMPLE_POLL
        BUILD_NAME = ARDISCOVERY_ERROR_BUILD_NAME
        CLIENT = ARDISCOVERY_ERROR_CLIENT
        CREATE_CONFIG = ARDISCOVERY_ERROR_CREATE_CONFIG
        DELETE_CONFIG = ARDISCOVERY_ERROR_DELETE_CONFIG
        ENTRY_GROUP = ARDISCOVERY_ERROR_ENTRY_GROUP
        ADD_SERVICE = ARDISCOVERY_ERROR_ADD_SERVICE
        GROUP_COMMIT = ARDISCOVERY_ERROR_GROUP_COMMIT
        BROWSER_ALLOC = ARDISCOVERY_ERROR_BROWSER_ALLOC
        BROWSER_NEW = ARDISCOVERY_ERROR_BROWSER_NEW

        ALLOC = ARDISCOVERY_ERROR_ALLOC
        INIT = ARDISCOVERY_ERROR_INIT
        SOCKET_CREATION = ARDISCOVERY_ERROR_SOCKET_CREATION
        SOCKET_PERMISSION_DENIED = ARDISCOVERY_ERROR_SOCKET_PERMISSION_DENIED
        SOCKET_ALREADY_CONNECTED = ARDISCOVERY_ERROR_SOCKET_ALREADY_CONNECTED
        ACCEPT = ARDISCOVERY_ERROR_ACCEPT
        SEND = ARDISCOVERY_ERROR_SEND
        READ = ARDISCOVERY_ERROR_READ
        SELECT = ARDISCOVERY_ERROR_SELECT
        TIMEOUT = ARDISCOVERY_ERROR_TIMEOUT
        ABORT = ARDISCOVERY_ERROR_ABORT
        PIPE_INIT = ARDISCOVERY_ERROR_PIPE_INIT
        BAD_PARAMETER = ARDISCOVERY_ERROR_BAD_PARAMETER
        BUSY = ARDISCOVERY_ERROR_BUSY
        SOCKET_UNREACHABLE = ARDISCOVERY_ERROR_SOCKET_UNREACHABLE
        OUTPUT_LENGTH = ARDISCOVERY_ERROR_OUTPUT_LENGTH

        JNI = ARDISCOVERY_ERROR_JNI
        JNI_VM = ARDISCOVERY_ERROR_JNI_VM
        JNI_ENV = ARDISCOVERY_ERROR_JNI_ENV
        JNI_CALLBACK_LISTENER = ARDISCOVERY_ERROR_JNI_CALLBACK_LISTENER

        CONNECTION = ARDISCOVERY_ERROR_CONNECTION
        CONNECTION_BUSY = ARDISCOVERY_ERROR_CONNECTION_BUSY
        CONNECTION_NOT_READY = ARDISCOVERY_ERROR_CONNECTION_NOT_READY
        CONNECTION_BAD_ID = ARDISCOVERY_ERROR_CONNECTION_BAD_ID

        DEVICE = ARDISCOVERY_ERROR_DEVICE
        DEVICE_OPERATION_NOT_SUPPORTED = ARDISCOVERY_ERROR_DEVICE_OPERATION_NOT_SUPPORTED

        JSON = ARDISCOVERY_ERROR_JSON
        JSON_PARSSING = ARDISCOVERY_ERROR_JSON_PARSSING
        JSON_BUFFER_SIZE = ARDISCOVERY_ERROR_JSON_BUFFER_SIZE


cdef class Drone:
    cdef ARDISCOVERY_Device_t *_c_device
    cdef ARCONTROLLER_Device_t *_c_controller

    def connect(self, name, address, int port):
        cdef eARDISCOVERY_ERROR discovery_error = ARDISCOVERY_OK
        cdef ARDISCOVERY_Device_t *device = ARDISCOVERY_Device_New(&discovery_error)

        if not device:
            raise MemoryError()

        if discovery_error:
            raise ARDiscoveryError(discovery_error)

        name = name.encode('utf-8')
        address = address.encode('utf-8')

        cdef char* cName = name
        cdef char* cAddress = address

        discovery_error = ARDISCOVERY_Device_InitWifi(
            device,
            ARDISCOVERY_PRODUCT_ARDRONE,
            cName,
            cAddress,
            port)

        if discovery_error:
            raise ARDiscoveryError(discovery_error)

        self._c_device = device

        cdef eARCONTROLLER_ERROR controller_error = ARCONTROLLER_OK

        cdef ARCONTROLLER_Device_t *controller = ARCONTROLLER_Device_New(
                device, &controller_error)
        if controller_error:
            raise Error(controller_error)

        controller_error = ARCONTROLLER_Device_Start(controller)
        if controller_error:
            raise Error(controller_error)

        self._c_controller = controller

    cpdef take_off(self):
        self._c_controller.aRDrone3.sendPilotingTakeOff

