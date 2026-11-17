package game.socket

import encore.utils.hexString
import java.io.DataInputStream

/**
 * A fallback for unknown or unmade Yitien messages.
 * - [readBytes] reads the input bytes into a hex string.
 * - [bytes] provides the raw bytes of the data section.
 * - [toString] will return that hex string.
 */
class FallbackYitienFanchant(private val messageType: Int) : YitienFanchant {
    override val type: String = "<fallback-type>"
    private var hexStr = ""
    var bytes = byteArrayOf()

    override fun readBytes(bytes: DataInputStream) {
        this.bytes = bytes.readAllBytes()
        hexStr = this.bytes.hexString()
    }

    override fun toString(): String {
        return "messageType=$messageType, bytes=$hexStr"
    }
}
