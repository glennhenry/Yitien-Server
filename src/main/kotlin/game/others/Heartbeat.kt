package game.others

import game.socket.YitienFanchant
import game.socket.YitienMessageType
import game.utils.autoToString
import java.io.DataInputStream

class Heartbeat: YitienFanchant {
    override val type: String = YitienMessageType.CG_HEARTBEAT.toString()

    var code: Int = 0

    override fun readBytes(bytes: DataInputStream) {
        code = bytes.readInt()
    }

    override fun toString(): String {
        return this.autoToString()
    }
}
