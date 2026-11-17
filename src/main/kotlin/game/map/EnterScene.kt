package game.map

import game.socket.YitienFanchant
import game.socket.YitienMessageType
import game.utils.autoToString
import java.io.DataInputStream

class EnterScene: YitienFanchant {
    override val type: String = YitienMessageType.CG_ENTER_SCENE.toString()

    var roleId: Long = 0

    override fun readBytes(bytes: DataInputStream) {
        roleId = bytes.readLong()
    }

    override fun toString(): String {
        return autoToString()
    }
}
