package game.socket

import java.io.DataOutputStream

/**
 * Represent a message the server send to client in the socket connection.
 *
 * Implementation defines how to package itself into bytes in [write].
 * The bytes package must adhere to the client's expectation.
 */
interface OutgoingMessage {
    /**
     * Package the message into bytes.
     *
     * This only writes the data section and does not include the envelope details.
     *
     * Typically this isn't called directly but by the utility [createMessage].
     */
    fun write(output: DataOutputStream)
}
