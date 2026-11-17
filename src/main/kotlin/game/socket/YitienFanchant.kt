package game.socket

import encore.network.fanchant.Fanchant
import game.utils.autoToString
import java.io.DataInputStream

/**
 * Representation of [Fanchant] for Yitien network messages.
 *
 * This fanchant represent socket message sent by client for server.
 * - [readBytes]: provides a [DataInputStream] to read the received network payload.
 *
 * Implementation generally:
 * - Inherit this fanchant class instead of the root [Fanchant].
 * - List every properties of the message. To obtain the list of properties,
 *   refer to the client code.
 * - Inside [readBytes], parse the input byte array according to how the client
 *   package the payload, and populate every properties.
 * - May implement [toString] with [autoToString].
 */
interface YitienFanchant : Fanchant {
    /**
     * Populate local properties of the fanchant from input [bytes].
     */
    fun readBytes(bytes: DataInputStream)
}
