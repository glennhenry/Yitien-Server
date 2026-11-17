package game.auth

import game.socket.YitienFanchant
import game.socket.YitienMessageType
import game.utils.autoToString
import java.io.DataInputStream

/**
 * CG_ASK_LOGIN 1001
 */
class CGAskLogin : YitienFanchant {
    override val type: String = YitienMessageType.CG_ASK_LOGIN.toString()

    var account: String = ""
    var fcm: Int = 0
    var openkey: String = ""
    var invkey: String = ""
    var itime: String = ""
    var iopenid: String = ""
    var zoneId: String = "0"
    var pf: String = ""
    var fpkey: String = ""
    var user_source: String = ""
    var contract_id: String = ""
    var app_custom: String = ""
    var fd: String = ""
    var via: String = ""
    var seqid: String = ""
    var adtag: String = ""

    override fun readBytes(bytes: DataInputStream) {
        account = bytes.readUTF()
        fcm = bytes.readByte().toInt()
        openkey = bytes.readUTF()
        invkey = bytes.readUTF()
        itime = bytes.readUTF()
        iopenid = bytes.readUTF()
        zoneId = bytes.readUTF()
        pf = bytes.readUTF()
        fpkey = bytes.readUTF()
        user_source = bytes.readUTF()
        contract_id = bytes.readUTF()
        app_custom = bytes.readUTF()
        fd = bytes.readUTF()
        via = bytes.readUTF()
        seqid = bytes.readUTF()
        adtag = bytes.readUTF()
    }

    override fun toString(): String {
        return this.autoToString()
    }
}
