package game.auth

import game.character.Hero
import game.socket.OutgoingMessage
import java.io.DataOutputStream

/**
 * @property isSuccess
 * @property key A value between 0-255 to reset the flashvars' given key.
 */
class AskCharlistMessage(
    val isSuccess: Boolean, val key: UByte,
    val heroes: List<Hero>
) : OutgoingMessage {
    override fun write(output: DataOutputStream) {
        val result = if (isSuccess) 1 else 0
        output.writeShort((key.toInt() shl 8) or result)
        output.writeShort(heroes.size)
        for (hero in heroes) {
            hero.write(output)
        }
    }
}
