package game.socket

import encore.network.fanchant.Fanchant
import encore.network.fanchant.guide.DecodeResult
import encore.network.fanchant.guide.FanchantGuide
import encore.utils.startsWithString
import game.auth.AskCharlist
import game.auth.CGAskLogin
import game.others.Heartbeat
import java.io.DataInputStream

/**
 * [FanchantGuide] implementation for Yitien messages.
 * - [verify] returns `true` as long as it don't starts with `GET`.
 * - [tryDecode] simply unwraps the message into a `messageType` and data section.
 * - [materialize] list every recognized fanchant and distribute it based on `messageType`.
 *   See [YitienMessageType] for a full list.
 */
class YitienFanchantGuide : FanchantGuide<Pair<Int, ByteArray>> {
    override fun verify(data: ByteArray): Boolean {
        return !data.startsWithString("GET")
    }

    override fun tryDecode(data: ByteArray): DecodeResult<Pair<Int, ByteArray>> {
        val input = DataInputStream(data.inputStream())

        val messageLength = input.readInt()
        val bodyLength = messageLength - 4
        val messageType = input.readInt()

        if (input.available() < bodyLength) {
            return DecodeResult.Failure(
                "Invalid message: " +
                        "expected body length is $bodyLength bytes but remaining " +
                        "${input.available()} bytes"
            )
        }

        val data = input.readNBytes(messageLength)
        return DecodeResult.Success(messageType to data)
    }

    override fun materialize(decoded: Pair<Int, ByteArray>): Fanchant {
        val (messageType, bytes) = decoded

        // add more message entries here...
        val fanchantClass: YitienFanchant = when (messageType) {
            YitienMessageType.CG_ASK_LOGIN -> CGAskLogin()
            YitienMessageType.CG_ASK_CHARLIST -> AskCharlist()
            YitienMessageType.CG_HEARTBEAT -> Heartbeat()
            else -> FallbackYitienFanchant(messageType)
        }
        val input = DataInputStream(bytes.inputStream())
        fanchantClass.readBytes(input)

        return fanchantClass
    }
}
