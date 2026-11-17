package game.auth

import encore.fancam.Fancam
import encore.network.handler.FanchantHandler
import encore.network.handler.HandlerContext
import game.socket.YitienMessageType
import game.socket.createMessage

class AskLoginHandler : FanchantHandler<CGAskLogin> {
    override val fanchantType: String = YitienMessageType.CG_ASK_LOGIN.toString()

    override suspend fun handle(ctx: HandlerContext<CGAskLogin>) = with(ctx) {
        Fancam.info { "Got AskLogin: ${ctx.fanchant}" }
        connection.write(
            createMessage(
                YitienMessageType.GC_ASK_LOGIN,
                AskLoginMessage(isSuccess = true)
            )
        )
    }
}
