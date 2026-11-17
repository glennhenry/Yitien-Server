package game.character

import game.socket.OutgoingMessage
import java.io.DataOutputStream

data class Hero(
    val heroId: Long,
    val heroName: String,
    val short1: Int,
    val short2: Int,
    val short3: Int
): OutgoingMessage {
    override fun write(output: DataOutputStream) {
        output.writeLong(heroId)
        output.writeUTF(heroName)
        output.writeShort(short1)
        output.writeShort(short2)
        output.writeShort(short3)
    }
}
