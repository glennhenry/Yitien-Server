package game.map

import encore.network.handler.FanchantHandler
import encore.network.handler.HandlerContext
import game.socket.YitienMessageType
import game.socket.createMessage

class EnterSceneHandler : FanchantHandler<EnterScene> {
    override val fanchantType: String = YitienMessageType.CG_ENTER_SCENE.toString()

    override suspend fun handle(ctx: HandlerContext<EnterScene>) = with(ctx) {
        connection.write(
            createMessage(
                YitienMessageType.GC_ENTER_SCENE,
                // sceneId see mapRes assets
                // 12101 is some volcano map apparently
                EnterSceneMessage(true, 12101, 12, 10)
            )
        )
    }
}
