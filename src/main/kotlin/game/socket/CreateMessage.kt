package game.socket

import encore.network.transport.Connection
import java.io.ByteArrayOutputStream
import java.io.DataOutputStream

/**
 * A utility to create message to be sent in the socket.
 *
 * - Provide `messageType` and outgoing message representation.
 * - This will call [OutgoingMessage.write] to package the data.
 * - Wrap the data with envelope details.
 * - Return a ready-to-sent bytearray in [Connection].
 *
 * @param messageType `messageType`
 * @param outgoing [OutgoingMessage]
 */
fun createMessage(messageType: Int, outgoing: OutgoingMessage): ByteArray {
    // data section
    val dataStream = ByteArrayOutputStream()
    val dataOutput = DataOutputStream(dataStream)
    outgoing.write(dataOutput)
    dataOutput.flush()
    val dataSection = dataStream.toByteArray()

    // envelope
    val stream = ByteArrayOutputStream()
    val output = DataOutputStream(stream)

    // total length
    output.writeInt(dataSection.size + 8)

    // messageType
    output.writeInt(messageType)

    // data section
    output.write(dataSection)

    output.flush()
    return stream.toByteArray()
}
