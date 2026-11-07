package
{
   import manager.HtmlUtil;
   
   public class Model_initStr
   {
      
      public static var ZHONGWENMING_CHANGDU:String;
      
      public static var WITH_NAME:String;
      
      public static var ENTER_GAME:String;
      
      public static var NAME_COM:String;
      
      public static var INPUT_NAME:String;
      
      public static var CLICK_IN_NAME:String;
      
      public static var CHOOSE_HERO:String;
      
      public static var DEFAULT_NAME:String;
      
      public static var CHONGFU_NAME:String;
      
      public static var CHOOSE_ONE_HERO:String;
      
      public static var NAME_NOT_NULL:String;
      
      public static var NAME_LENGHT:String;
      
      public static var STORE_YITIAN:String;
      
      public static var DEVELOPERS:String;
      
      public static var FIRST_NAME:Array;
      
      public static var SEND_MAN_NAME_1:Array;
      
      public static var SEND_MAN_NAME_2:Array;
      
      public static var SEND_WOMEN_NAME_1:Array;
      
      public static var SEND_WOMEN_NAME_2:Array;
      
      public static var MENPAI:Array;
      
      public static var OFFLINETIP:String;
      
      public static var VIEW_ALERT_OK:String;
      
      public static var VIEW_ALERT_CANCEL:String;
      
      public static var VIEW_ALERT_STR1:String;
      
      public static var YT_TITLE:String;
      
      public static var YT_DISCRIPT:String;
      
      public static var YT_SUMMARY:String;
      
      public static var OFFLINE_STR1:String;
      
      public static var OFFLINE_STR2:String;
      
      public static var LINK_SERVER:String;
      
      public static var INIT_GAME:String;
      
      public static var LOAD_CREATE:String;
      
      public static var LOAD_MAIN:String;
      
      public static var CONTAIN_FAIL_WORD:String;
      
      public function Model_initStr()
      {
         super();
      }
      
      public static function initStr() : void
      {
         LINK_SERVER = "连接服务器";
         INIT_GAME = "游戏初始化";
         LOAD_CREATE = "加载创建页";
         LOAD_MAIN = "加载游戏主文件";
         CONTAIN_FAIL_WORD = "包含以下非法字符：";
         ZHONGWENMING_CHANGDU = "角色名长度为2-6个字节";
         WITH_NAME = "以名字";
         ENTER_GAME = "进入游戏";
         NAME_COM = "角色名只能是中文、英文、数字的组合";
         INPUT_NAME = "请输入角色名";
         CLICK_IN_NAME = "点击自动取名";
         CHOOSE_HERO = "请先选择英雄";
         DEFAULT_NAME = "以默认角色名进入游戏";
         CHONGFU_NAME = "名字重复，请重新取名";
         CHOOSE_ONE_HERO = "请选择一个英雄";
         NAME_NOT_NULL = "角色名不能为空";
         NAME_LENGHT = "角色名长度为2-6个字";
         MENPAI = ["天刀门：刚毅勇猛，防御气血高，冲锋陷阵所向披靡。","逍遥剑派：剑如闪电，攻击高，斩敌在瞬息之间。","医仙谷：俊俏文雅，命中内力高，文武兼备真英雄。","刺客盟：冷若星辰，暴击闪避高，控敌于股掌之中。"];
         STORE_YITIAN = "收藏《倚天》";
         DEVELOPERS = "开发商：天拓游戏";
         FIRST_NAME = ["司马","欧阳","端木","上官","独孤","夏侯","尉迟","赫连","皇甫","公孙","慕容","长孙","宇文","司徒","轩辕","百里","呼延","令狐","诸葛","南宫","东方","西门","李","王","张","刘","陈","杨","赵","黄","周","胡","林","梁","宋","郑","唐","冯","董","程","曹","袁","许","沈","曾","彭","吕","蒋","蔡","魏","叶","杜","夏","汪","田","方","石","熊","白","秦","江","孟","龙","万","段","雷","武","乔","洪","鲁","葛","柳","岳","梅","辛","耿","关","苗","童","项","裴","鲍","霍","甘","景","包","柯","阮","华","穆","燕","敖","冷","卓","花","蓝","楚","荆","丹青V","潇湘V","杏花天V","菩萨蛮V","商羽V","墨笔V","妙手V","飞狐V","银狐V","金狐V","酒剑仙V","耶律V","百花使V","临江仙V","白眉V","医仙V","智多星V","紫衫V","醉花阴V","一丈青V","玉笛仙V","西门V","逍遥V","楚天谣V","御猫V","双雄V","玉面V","战将V","南拳V","北腿V","东枪V","西棍V","白贼V","黑风V","刀者V","龙侠V","侠盗使V","独孤V","伏魔者V","罗汉V","墨者V","玄狐V","青玉案V","皇甫V","叶孤V","白黎V","楚夫V","","魂魄V","神惊V","拳圣V","道圣V","将帅V","武者V","英雄V","帝王V","千仞V","霸者V","豪侠V","成吉V","可汗V","大汗V","诸王V","四象V","单双V","慕侠V","诸葛V","佛陀V","道广V","智兴V","二郎V","太祖V","万仞V","隋刃V","青龙V","裴旻V","龙藻V","狻猊V","墨阳V","雌雄V","莫邪V","龙渊V","胜邪V","星辰V","勾践V","辟邪V","百里V","神话V","傲视V","七羽V","莫柒V","单色V","修米V","狼族V"
         ,"情意V","冥灵V","皇朝V","非凡V","乱世V","幻情V","风云V","血战V","七喜V","相依V","起凡V","魔团V","年华V","飘渺V","傲世V","问天V","狼醉V","恶魔V","夕阳V","时尚V","巅峰V","情深V","守护V","情缘V","至尊V","飞龙V","阳光V","柒偌V","冰瞳V","初颜V","维纳斯V","舞夜V","淡岩V","独狼V","炫狼V","云游V","花凋零V","梦魂V","梦橫V","完美V","泽柒V","莫忘V","皇家V","幽梦V","冷落V","心碎V","无道V","残阳V","卡西V","龙天V","情郎V","红颜V","尤里V","无夕V","苍神月V","超级V","惩罚V","轩冥天V","玛法V","众神V","幽冥V","潇洒V","雪魄V","王者V","光明V","圣光V","洛熙V","龙翔V","泓色V","黑色V","风之残V","传奇V","曙光V","梦之城V","疯狂V","黑翼V","邪魅V","飘逸V","逆天V","辰逸V","永恒V","神界V","夏雨V","影魔V","神藏V","初颜V","热血V","统战V","狼魂V","决战V","独白V","禁域V","葬送V","晓潴V","岁月V","非凡V","百花楼V","潮尚V","紫月V","叁国V","魅力V","情之音V","天涯V","蓝缘V","轩轩V","霸气V","情调V","傲剑V","隐风V","血煞V","寒衣V","鸣一V","木落V","明月V","清风V","逍遥V","盗帅V","留香V","蜀山V","沧海V","梁祝V","仙聚V","贵族V","轩辕V","龙鹤V","皇上皇V","神泣V","血族V","雄霸V","紫禁V","弑念V","圣域V","幻城V","龙氏V","虚夜宫V","情谊V"];
         SEND_MAN_NAME_1 = ["峰","不","近","小","千","万","百","一","求","笑","双","凌","伯","仲","叔","震","飞","晓","昌","霸","冲","志","留","九","子","立","小","云","文","安","博","才","光","弘","华","清","灿","俊","凯","乐","良","明","健","辉","天","星","永","玉","英","真","修","义","雪","嘉","成","傲","欣","逸","飘","凌","青","火","森","杰","思","智","辰","元","夕","苍","劲","巨","潇","紫","邪","尘"];
         SEND_MAN_NAME_2 = ["败","悔","南","宝","仞","刀","斐","德","云","天","仁","岳","宵","忌","爵","权","敏","阳","狂","冠","康","平","香","刚","强","凡","邦","福","歌","国","和","康","澜","民","宁","然","顺","翔","晏","宜","怡","易","志","雄","佑","斌","河","元","墨","松","林","之","翔","竹","宇","轩","荣","哲","风","霜","山","炎","罡","盛","睿","达","洪","武","耀","磊","寒","冰","潇","痕","岚","空"];
         SEND_WOMEN_NAME_1 = ["思","冰","夜","痴","依","小","香","绿","向","映","含","曼","醉","之","新","雨","天","如","若","涵","亦","采","冬","安","芷","绮","雅","飞","又","寒","忆","晓","乐","笑","妙","元","碧","翠","初","怀","幻","慕","秋","语","觅","幼","灵","傲","冷","沛","念","寻","水","紫","易","惜","诗","青","雁","盼","尔","以","雪","夏","凝","丹","迎","问","宛","梦","怜","听","巧","凡","静"];
         SEND_WOMEN_NAME_2 = ["烟","琴","蓝","梦","丹","柳","冬","萍","菱","寒","阳","霜","白","丝","南","真","露","云","芙","筠","容","香","荷","风","儿","雪","巧","蕾","芹","柔","灵","卉","夏","岚","蓉","萱","珍","彤","蕊","曼","凡","兰","晴","珊","易","青","玉","瑶","文","双","竹","凝","桃","菡","绿","枫","梅","旋","山","松","之","亦","蝶","莲","柏","波","安","天","薇","海","翠","槐","秋","雁","夜"];
         OFFLINETIP = "<font color=\'#FFFFFF\'>亲爱的，您暂时与服务器失去了链接<br>可能是出于下面的原因：<br>" + "      1、您的账号重复登陆了<br>" + "      2、您掉线了<br>" + "      3、您的网络不稳定<br>" + "      4、服务器维护中<br>" + "      请放心，我们已经保存了您的数据，请</font>" + "<u>" + HtmlUtil.fontNoSize(HtmlUtil.link("重新登陆","link"),"#FFFF00") + "</u>";
         VIEW_ALERT_STR1 = "    尊敬的玩家，您的账号已经被封禁,<br/>可能是出于下面的原因：<br/>" + "1、您的账号使用第三方软件进行游戏<br/>" + "2、您的账号在游戏中发布违法信息<br/>" + "3、您的账号内存在非法途径获得的道具<br/>" + "4、您在游戏中3次验证错误、短暂封号<br/>" + "    如果您对上述情况存在疑问，请点击" + "<u>" + HtmlUtil.fontNoSize(HtmlUtil.link("了解详情","link"),"#ff0000") + "</u>";
         YT_TITLE = "倚天";
         YT_DISCRIPT = "我发现了一款新游戏《倚天》不错，一起来试试吧！";
         YT_SUMMARY = "倚天屠龙，谁与争锋。每个人心中都有一个武侠梦，而你的武林就在这里！";
         OFFLINE_STR1 = "网络已断开";
         OFFLINE_STR2 = "被踢下线";
      }
   }
}

