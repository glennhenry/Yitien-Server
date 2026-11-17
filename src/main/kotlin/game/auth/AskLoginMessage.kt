package game.auth

import game.socket.OutgoingMessage
import java.io.DataOutputStream

class AskLoginMessage(val isSuccess: Boolean): OutgoingMessage {
    override fun write(output: DataOutputStream) {
        if (isSuccess) {
            output.writeShort(1)
        } else {
            // not required
            output.writeShort(-1)
        }
    }
}
