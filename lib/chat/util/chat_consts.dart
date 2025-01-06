// ignore_for_file: constant_identifier_names

class ChatConsts {
  // 本地
  static const bool isDebug = true;
  static const String httpBaseUrl = '127.0.0.1:9003';
  static const String webSocketUrl = 'ws://127.0.0.1:9885/websocket';

  // 线上
  // static const bool isDebug = false;
  // static const String httpBaseUrl = 'api.weiyuai.cn';
  // static const String webSocketUrl = 'wss://api.weiyuai.cn/websocket';

  //
  static const String website = 'weiyuai.cn';
  static const String websiteUrl = 'https://$website';
  static const String firstOpen = "firstOpen";
  //
  static const String defaultOrgUid = "df_org_uid"; // 组织uid
  static const String workGroupUid = "df_wg_uid"; // 客服技能组uid
  //
  static const String isWifi = "is_wifi";
  static const String platform = "BYTEDESK";
  static const String isDarkMode = "is_dark_mode";

  // 本地
  static const String currentThreadTopic = "currentThreadTopic";
  //
  // 是否登录
  static const String isLogin = 'bytedesk_isLogin';
  static const String isExitLogin = 'bytedesk_isExitLogin';
  //
  static const String accessToken = 'bytedesk_accessToken';
  static const String user = 'bytedesk_user';
  static const String uid = 'bytedesk_uid';
  static const String username = 'bytedesk_username';
  static const String password = 'bytedesk_password';
  static const String nickname = 'bytedesk_nickname';
  static const String avatar = 'bytedesk_avatar';
  static const String description = 'bytedesk_description';
  static const String mobile = 'bytedesk_mobile';
  //
  static const String orgUid = 'bytedesk_orguid';
  static const String deviceUid = 'bytedesk_deviceuid';
  static const String memberSelfUid = 'bytedesk_memberSelfUid';
  //
  static const String userInfo = 'bytedesk_userInfo';
  static const String agentInfo = 'bytedesk_agentInfo';
  //
  static const String VIDEO_PLAY =
      "https://cdn.weiyuai.cn/agent/assets/images/video_play.png";
  //
  // 连接中
  static const String USER_STATUS_CONNECTING = "connecting";
  // 跟服务器建立长连接
  static const String USER_STATUS_CONNECTED = "connected";
  // 断开长连接
  static const String USER_STATUS_DISCONNECTED = "disconnected";
  //
  static const USER_TYPE_AGENT = "AGENT";
  static const USER_TYPE_SYSTEM = "SYSTEM";
  static const USER_TYPE_VISITOR = "VISITOR";
  static const USER_TYPE_ROBOT = "ROBOT";
  static const USER_TYPE_MEMBER = "MEMBER";
  static const USER_TYPE_ASSISTANT = "ASSISTANT";
  static const USER_TYPE_CHANNEL = "CHANNEL";
  static const USER_TYPE_LOCAL = "LOCAL";
  static const USER_TYPE_USER = "USER";

  // 会话类型 = 工作组会话、访客跟客服一对一、同事一对一、群组会话
  static const THREAD_TYPE_AGENT = "AGENT";
  static const THREAD_TYPE_WORKGROUP = "WORKGROUP";
  static const THREAD_TYPE_KB = "KB";
  static const THREAD_TYPE_KBDOC = "KBDOC";
  static const THREAD_TYPE_LLM = "LLM";
  static const THREAD_TYPE_MEMBER = "MEMBER";
  static const THREAD_TYPE_GROUP = "GROUP";
  static const THREAD_TYPE_LEAVEMSG = "LEAVEMSG";
  static const THREAD_TYPE_FEEDBACK = "FEEDBACK";
  static const THREAD_TYPE_ASSISTANT = "ASSISTANT";
  static const THREAD_TYPE_CHANNEL = "CHANNEL";
  static const THREAD_TYPE_LOCAL = "LOCAL";
  //
  static const String THREAD_STATUS_QUEUING = "QUEUING"; // 排队中
  static const String THREAD_STATUS_NORMAL = "NORMAL"; // 正常
  static const String THREAD_STATUS_REENTER =
      "REENTER"; // 会话进行中，访客关闭会话页面之后，重新进入
  static const String THREAD_STATUS_REOPEN = "REOPEN"; // 会话关闭之后，重新进入
  static const String THREAD_STATUS_OFFLINE = "OFFLINE"; // 客服不在线
  static const String THREAD_STATUS_RATED =
      "RATED"; // rated, prevent repeated rate
  static const String THREAD_STATUS_AUTO_CLOSED = "AUTO_CLOSED";
  static const String THREAD_STATUS_AGENT_CLOSED = "AGENT_CLOSED";
  static const String THREAD_STATUS_DISMISSED = "DISMISSED"; // 会话解散
  static const String THREAD_STATUS_MUTED = "MUTED"; // 会话静音
  static const String THREAD_STATUS_FORBIDDEN = "FORBIDDEN"; // 会话禁言
  static const String THREAD_STATUS_MONITORED = "MONITORED"; // 会话监控

  // 消息发送状态
  // 发送中
  static const String MESSAGE_STATUS_SENDING = "SENDING"; // sending
  static const String MESSAGE_STATUS_TIMEOUT = "TIMEOUT"; // network send failed
  static const String MESSAGE_STATUS_BLOCKED = "BLOCKED"; // in black list
  static const String MESSAGE_STATUS_NOTFRIEND = "NOTFRIEND"; // not friend
  static const String MESSAGE_STATUS_ERROR = "ERROR"; // other send error
  static const String MESSAGE_STATUS_SUCCESS = "SUCCESS"; // send success
  static const String MESSAGE_STATUS_RECALL = "RECALL"; // recall back
  static const String MESSAGE_STATUS_DELIVERED =
      "DELIVERED"; // send to the other client
  static const String MESSAGE_STATUS_READ = "READ"; // read by the other client
  static const String MESSAGE_STATUS_DESTROYED =
      "DESTROYED"; // destroyed after read
  static const String MESSAGE_STATUS_UNPRECESSED =
      "UNPRECESSED"; // not processed
  static const String MESSAGE_STATUS_PROCESSED =
      "PROCESSED"; // leave message processed
  static const String MESSAGE_STATUS_LEAVE_MSG_SUBMIT =
      "LEAVE_MSG_SUBMIT"; // 提交留言
  static const String MESSAGE_STATUS_RATE_SUBMIT = "RATE_SUBMIT"; // 提交会话评价
  static const String MESSAGE_STATUS_RATE_CANCEL = "RATE_CANCEL"; // 取消会话评价
  static const String MESSAGE_STATUS_RATE_UP = "RATE_UP"; // 评价消息up
  static const String MESSAGE_STATUS_RATE_DOWN = "RATE_DOWN"; // 评价消息down
  static const String MESSAGE_STATUS_TRANSFER_ACCEPT =
      "TRANSFER_ACCEPT"; // 转接-接受
  static const String MESSAGE_STATUS_TRANSFER_REJECT =
      "TRANSFER_REJECT"; // 转接-拒绝
  static const String MESSAGE_STATUS_INVITE_ACCEPT = "INVITE_ACCEPT"; // 邀请-接受
  static const String MESSAGE_STATUS_INVITE_REJECT = "INVITE_REJECT"; // 邀请-拒绝
  //
  // 消息类型
  static const String MESSAGE_TYPE_WELCOME = "WELCOME";
  static const String MESSAGE_TYPE_CONTINUE = "CONTINUE";
  static const String MESSAGE_TYPE_SYSTEM = "SYSTEM";
  static const String MESSAGE_TYPE_NOTICE = "NOTICE"; // 通知消息类型
  static const String MESSAGE_TYPE_TEXT = "TEXT"; // 文本消息类型
  static const String MESSAGE_TYPE_IMAGE = "IMAGE"; // 图片消息类型
  static const String MESSAGE_TYPE_FILE = "FILE"; // 文件消息类型
  static const String MESSAGE_TYPE_AUDIO = "AUDIO"; // 语音消息类型
  static const String MESSAGE_TYPE_VIDEO = "VIDEO"; // 视频消息类型
  static const String MESSAGE_TYPE_MUSIC = "MUSIC";
  static const String MESSAGE_TYPE_LOCATION = "LOCATION";
  static const String MESSAGE_TYPE_GOODS = "GOODS";
  static const String MESSAGE_TYPE_CARD = "CARD";
  static const String MESSAGE_TYPE_EVENT = "EVENT";
  //
  static const String MESSAGE_TYPE_GUESS = "GUESS"; // 猜你想问
  static const String MESSAGE_TYPE_HOT = "HOT"; // 热门问题
  static const String MESSAGE_TYPE_SHORTCUT = "SHORTCUT"; // 快捷路径
  static const String MESSAGE_TYPE_ORDER = "ORDER"; // 订单
  static const String MESSAGE_TYPE_POLL = "POLL"; // 投票
  static const String MESSAGE_TYPE_FORM = "FORM"; // 表单：询前表单
  static const String MESSAGE_TYPE_LEAVE_MSG = "LEAVE_MSG"; // 留言
  static const String MESSAGE_TYPE_LEAVE_MSG_SUBMIT =
      "LEAVE_MSG_SUBMIT"; // 留言提交
  static const String MESSAGE_TYPE_TICKET = "TICKET"; // 客服工单
  static const String MESSAGE_TYPE_TYPING = "TYPING"; // 正在输入
  static const String MESSAGE_TYPE_PROCESSING = "PROCESSING"; // 正在处理，等待大模型回复中
  static const String MESSAGE_TYPE_STREAM = "STREAM"; // 流式消息TEXT，大模型回复
  static const String MESSAGE_TYPE_PREVIEW = "PREVIEW"; // 消息预知
  static const String MESSAGE_TYPE_RECALL = "RECALL"; // 撤回
  static const String MESSAGE_TYPE_DELIVERED = "DELIVERED"; // 回执: 已送达
  static const String MESSAGE_TYPE_READ = "READ"; // 回执: 已读
  static const String MESSAGE_TYPE_QUOTATION = "QUOTATION"; // qoute message
  static const String MESSAGE_TYPE_KICKOFF = "KICKOFF"; // kickoff other clients
  static const String MESSAGE_TYPE_SHAKE = "SHAKE"; // shake window
  //
  static const String MESSAGE_TYPE_FAQ = "FAQ"; // 常见问题FAQ
  static const String MESSAGE_TYPE_FAQ_Q = "FAQ_Q"; // 常见问题FAQ-问题
  static const String MESSAGE_TYPE_FAQ_A = "FAQ_A"; // 常见问题FAQ-答案
  static const String MESSAGE_TYPE_FAQ_UP = "FAQ_UP"; // 常见问题答案评价:UP
  static const String MESSAGE_TYPE_FAQ_DOWN = "FAQ_DOWN"; // 常见问题答案评价:DOWN
  static const String MESSAGE_TYPE_ROBOT = "ROBOT"; // 机器人
  static const String MESSAGE_TYPE_ROBOT_UP = "ROBOT_UP"; // 机器人答案评价:UP
  static const String MESSAGE_TYPE_ROBOT_DOWN = "ROBOT_DOWN"; // 机器人答案评价:DOWN
  //
  static const String MESSAGE_TYPE_RATE = "RATE"; // 访客主动评价
  static const String MESSAGE_TYPE_RATE_INVITE = "RATE_INVITE"; // 客服邀请评价
  static const String MESSAGE_TYPE_RATE_SUBMIT = "RATE_SUBMIT"; // 访客提交评价
  static const String MESSAGE_TYPE_RATE_CANCEL = "RATE_CANCEL"; // 访客取消评价
  //
  static const String MESSAGE_TYPE_AUTO_CLOSED = "AUTO_CLOSED"; // 自动关闭
  static const String MESSAGE_TYPE_AGENT_CLOSED = "AGENT_CLOSED"; // 客服关闭
  //
  static const String MESSAGE_TYPE_TRANSFER = "TRANSFER"; // 转接
  static const String MESSAGE_TYPE_TRANSFER_ACCEPT = "TRANSFER_ACCEPT"; // 转接-接受
  static const String MESSAGE_TYPE_TRANSFER_REJECT = "TRANSFER_REJECT"; // 转接-拒绝
  //
  static const String MESSAGE_TYPE_INVITE = "INVITE"; // 邀请
  static const String MESSAGE_TYPE_INVITE_ACCEPT = "INVITE_ACCEPT"; // 邀请-接受
  static const String MESSAGE_TYPE_INVITE_REJECT = "INVITE_REJECT"; // 邀请-拒绝
  //
  static const String AGENT_STATUS_AVAILABLE = "AVAILABLE";
  static const String AGENT_STATUS_BUSY = "BUSY";
  static const String AGENT_STATUS_OFFLINE = "OFFLINE";
  //
  static const ROBOT_TYPE_SERVICE = "SERVICE";
  static const ROBOT_TYPE_MARKETING = "MARKETING";
  static const ROBOT_TYPE_KB = "KB";
  static const ROBOT_TYPE_KBDOC = "KBDOC";
  static const ROBOT_TYPE_LLM = "LLM";
  //
  static const String CATEGORY_TYPE_QUICK_REPLY = "quick_reply";
  static const String CATEGORY_TYPE_FAQ = "faq";
  //
  static const String CATEGORY_TYPE_HELP_DOC = "help_doc";
  static const String CATEGORY_TYPE_ROBOT_KB = "robot_kb";
  static const String CATEGORY_TYPE_BLOG = "blog";
  static const String CATEGORY_TYPE_EMAIL = "email";
  //
  static const String GROUP_TYPE_MEMBER = "MEMBER";
  static const String GROUP_TYPE_USER = "USER";
  //
  static const String TOPIC_FILE_ASSISTANT = "file";
  static const String TOPIC_SYSTEM_NOTIFICATION = "system";
  // 注意：没有 '/' 开头，防止stomp主题中奖 '/' 替换为 '.'之后，在最前面多余一个 '.'
  static const String TOPIC_USER_PREFIX = "user/";
  // static const String TOPIC_PRIVATE_PREFIX = "private/";
  // static const String TOPIC_GROUP_PREFIX = "group/";
  static const String TOPIC_FILE_PREFIX = "file/";
  static const String TOPIC_SYSTEM_PREFIX = "system/";
  // static const String TOPIC_ROBOT_PREFIX = "robot/";
  //
  static const String TOPIC_ORGNIZATION_PREFIX = "org/";
  static const String TOPIC_ORG_MEMBER_PREFIX = "org/member/";
  static const String TOPIC_ORG_DEPARTMENT_PREFIX = "org/department/";
  static const String TOPIC_ORG_GROUP_PREFIX = "org/group/";
  static const String TOPIC_ORG_PRIVATE_PREFIX = "org/private/";
  static const String TOPIC_ORG_ROBOT_PREFIX = "org/robot/";
  static const String TOPIC_ORG_AGENT_PREFIX = "org/agent/";
  static const String TOPIC_ORG_WORKGROUP_PREFIX = "org/workgroup/";
  //
  static const String KB_TYPE_ASSISTANT = "ASSISTANT";
  static const String KB_TYPE_HELPDOC = "HELPDOC";
  static const String KB_TYPE_LLM = "LLM";
  static const String KB_TYPE_KEYWORD = "KEYWORD";
  static const String KB_TYPE_FAQ = "FAQ";
  static const String KB_TYPE_QUICKREPLY = "QUICKREPLY";
  static const String KB_TYPE_AUTOREPLY = "AUTOREPLY";
  static const String KB_TYPE_BLOG = "BLOG";
  static const String KB_TYPE_EMAIL = "EMAIL";
  static const String KB_TYPE_TABOO = "TABOO";
  //
  static const String UPLOAD_TYPE_ASSISTANT = "ASSISTANT";
  static const String UPLOAD_TYPE_HELPDOC = "HELPDOC";
  static const String UPLOAD_TYPE_LLM = "LLM";
  static const String UPLOAD_TYPE_KEYWORD = "KEYWORD";
  static const String UPLOAD_TYPE_FAQ = "FAQ";
  static const String UPLOAD_TYPE_QUICKREPLY = "QUICKREPLY";
  static const String UPLOAD_TYPE_AUTOREPLY = "AUTOREPLY";
  static const String UPLOAD_TYPE_BLOG = "BLOG";
  static const String UPLOAD_TYPE_EMAIL = "EMAIL";
  static const String UPLOAD_TYPE_TABOO = "TABOO";
  static const String UPLOAD_TYPE_CHAT = "CHAT";
  static const UPLOAD_TYPE_ATTACHMENT = "ATTACHMENT";
  //
  static const String AUTO_REPLY_TYPE_FIXED = "FIXED";
  static const String AUTO_REPLY_TYPE_KEYWORD = "KEYWORD";
  static const String AUTO_REPLY_TYPE_LLM = "LLM";
  //
  // static const String SEND_MOBILE_CODE_TYPE_LOGIN = "login";
  // static const String SEND_MOBILE_CODE_TYPE_REGISTER = "register";
  // static const String SEND_MOBILE_CODE_TYPE_FORGET = "forget";
  // static const String SEND_MOBILE_CODE_TYPE_VERIFY = "verify";
  //
  static const String AUTH_TYPE_MOBILE_REGISTER = "MOBILE_REGISTER";
  static const String AUTH_TYPE_MOBILE_LOGIN = "MOBILE_LOGIN";
  static const String AUTH_TYPE_MOBILE_RESET = "MOBILE_RESET";
  static const String AUTH_TYPE_MOBILE_VERIFY = "MOBILE_VERIFY";
  static const String AUTH_TYPE_EMAIL_REGISTER = "EMAIL_REGISTER";
  static const String AUTH_TYPE_EMAIL_LOGIN = "EMAIL_LOGIN";
  static const String AUTH_TYPE_EMAIL_RESET = "EMAIL_RESET";
  static const String AUTH_TYPE_EMAIL_VERIFY = "EMAIL_VERIFY";

  static const CLIENT_TYPE_SYSTEM = "SYSTEM";
  static const CLIENT_TYPE_SYSTEM_AUTO = "SYSTEM_AUTO"; // auto reply
  static const CLIENT_TYPE_SYSTEM_BOT = "SYSTEM_BOT"; // robot reply

  // Web 客户端类型
  static const CLIENT_TYPE_WEB = "WEB";
  static const CLIENT_TYPE_WEB_PC = "WEB_PC"; // pc端
  static const CLIENT_TYPE_WEB_H5 = "WEB_H5"; // h5端
  static const CLIENT_TYPE_WEB_VISITOR = "WEB_VISITOR"; // 访客端
  static const CLIENT_TYPE_WEB_ADMIN = "WEB_ADMIN"; // 管理端

  // 移动客户端类型
  static const CLIENT_TYPE_IOS = "IOS";
  static const CLIENT_TYPE_ANDROID = "ANDROID";

  // 桌面客户端类型
  static const CLIENT_TYPE_ELECTRON = "ELECTRON";
  static const CLIENT_TYPE_LINUX = "LINUX";
  static const CLIENT_TYPE_MACOS = "MACOS";
  static const CLIENT_TYPE_WINDOWS = "WINDOWS";

  // Flutter 客户端类型
  static const CLIENT_TYPE_FLUTTER = "FLUTTER";
  static const CLIENT_TYPE_FLUTTER_WEB = "FLUTTER_WEB";
  static const CLIENT_TYPE_FLUTTER_ANDROID = "FLUTTER_ANDROID";
  static const CLIENT_TYPE_FLUTTER_IOS = "FLUTTER_IOS";
  static const CLIENT_TYPE_FLUTTER_MACOS = "FLUTTER_MACOS";
  static const CLIENT_TYPE_FLUTTER_WINDOWS = "FLUTTER_WINDOWS";
  static const CLIENT_TYPE_FLUTTER_LINUX = "FLUTTER_LINUX";

  // UniApp 客户端类型
  static const CLIENT_TYPE_UNIAPP = "UNIAPP";
  static const CLIENT_TYPE_UNIAPP_WEB = "UNIAPP_WEB";
  static const CLIENT_TYPE_UNIAPP_ANDROID = "UNIAPP_ANDROID";
  static const CLIENT_TYPE_UNIAPP_IOS = "UNIAPP_IOS";

  // 微信客户端类型
  static const CLIENT_TYPE_WECHAT = "WECHAT";
  static const CLIENT_TYPE_WECHAT_MINI = "WECHAT_MINI";
  static const CLIENT_TYPE_WECHAT_MP = "WECHAT_MP";
  static const CLIENT_TYPE_WECHAT_WORK = "WECHAT_WORK";
  static const CLIENT_TYPE_WECHAT_KEFU = "WECHAT_KEFU";
  static const CLIENT_TYPE_WECHAT_CHANNEL = "WECHAT_CHANNEL";


  //
  static const LEVEL_TYPE_PLATFORM = "PLATFORM";
  static const LEVEL_TYPE_ORGNIZATION = "ORGANIZATION";
  static const LEVEL_TYPE_DEPARTMENT = "DEPARTMENT";
  static const LEVEL_TYPE_WORKGROUP = "WORKGROUP";
  static const LEVEL_TYPE_AGENT = "AGENT";
  static const LEVEL_TYPE_GROUP = "GROUP";
  static const LEVEL_TYPE_USER = "USER";
}
