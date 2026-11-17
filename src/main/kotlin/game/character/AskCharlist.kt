package game.character

import game.socket.YitienFanchant
import game.socket.YitienMessageType
import java.io.DataInputStream

/**
 * CG_ASK_CHARLIST 1003
 * empty payload
 */
class AskCharlist: YitienFanchant {
    override val type: String = YitienMessageType.CG_ASK_CHARLIST.toString()
    override fun readBytes(bytes: DataInputStream) {}
    override fun toString(): String {
        return "AskCharlist(1003, no payload)"
    }
}
