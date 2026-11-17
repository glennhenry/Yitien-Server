package game.others

import encore.fancam.Fancam
import encore.network.handler.FanchantHandler
import encore.network.handler.HandlerContext
import game.socket.YitienMessageType

class HeartbeatHandler : FanchantHandler<Heartbeat> {
    override val fanchantType: String = YitienMessageType.CG_HEARTBEAT.toString()

    override suspend fun handle(ctx: HandlerContext<Heartbeat>) = with(ctx) {
        Fancam.debug { "Got heartbeat: ${fanchant.code}" }
    }
}
