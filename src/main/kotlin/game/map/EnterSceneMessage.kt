package game.map

import game.socket.OutgoingMessage
import java.io.DataOutputStream

class EnterSceneMessage(
    val isSuccess: Boolean, val sceneId: Int,
    val targetX: Int, val targetY: Int
) : OutgoingMessage {
    override fun write(output: DataOutputStream) {
        if (isSuccess) output.writeByte(1) else output.writeByte(0)
        output.writeShort(sceneId)
        output.writeShort(targetX)
        output.writeShort(targetY)
    }
}
