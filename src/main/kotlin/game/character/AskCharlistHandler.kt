package game.character

import encore.network.handler.FanchantHandler
import encore.network.handler.HandlerContext
import game.socket.YitienMessageType
import game.socket.createMessage

class AskCharlistHandler : FanchantHandler<AskCharlist> {
    override val fanchantType: String = YitienMessageType.CG_ASK_CHARLIST.toString()

    override suspend fun handle(ctx: HandlerContext<AskCharlist>) = with(ctx) {
        connection.write(
            createMessage(
                YitienMessageType.GC_ASK_CHARLIST,
                AskCharlistMessage(true, 100U, listOf(
                    Hero(
                        heroId = 123,
                        heroName = "Yitien",
                        // unknown purposes
                        short1 = 12001,
                        short2 = 12002,
                        short3 = 12003
                    )
                ))
            )
        )
    }
}
