/* appearance */
static const unsigned int borderpx  = 0; /* border pixel of windows */
static const unsigned int snap      = 0; /* snap pixel */
static const int showbar            = 1; /* 0 means no bar */
static const int topbar             = 1; /* 0 means bottom bar */
static const char dmenufont[]       = "Ubuntu Mono Nerd Font:size=12";
static const char *fonts[]          = { dmenufont };

// color theme
static const char color_bg[]     = "#222222";
static const char color_fg[]     = "#bbbbbb";
static const char color_bg_sel[] = "#005577";
static const char color_fg_sel[] = "#eeeeee";

// set color
static const char *colors[][3]      = {
	[SchemeNorm] = { color_fg     , color_bg     , color_bg      },
	[SchemeSel]  = { color_fg_sel , color_bg_sel , color_bg_sel  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	{ "[]=", tile }, /* first entry is default */
	{ "><>", NULL }, /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run",
	"-m",  dmenumon,
	"-fn", dmenufont,
	"-nb", color_bg,
	"-nf", color_fg,
	"-sb", color_bg_sel,
	"-sf", color_fg_sel,
NULL };

static const char *open_tty[]  = { "st", NULL };
static const char *open_web[]  = { "firefox", NULL };

static Key keys[] = {
	// dmenu
	{ MODKEY,               XK_space,  spawn,          {.v = dmenucmd } },
	
	// app key binds
	{ MODKEY,               XK_t,      spawn,          {.v = open_tty } },
	{ MODKEY,               XK_w,      spawn,          {.v = open_web } },
	
	// handle
	{ MODKEY,               XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,               XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,               XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,               XK_k,      focusstack,     {.i = -1 } },

	// quit an app
	{ MODKEY,               XK_q,      killclient,     {0} },
	
	// logout
	{ MODKEY,               XK_Escape, quit,           {0} },
	
	// all the tags!
	{ MODKEY,               XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,     XK_0,      tag,            {.ui = ~0 } },
	
	// handle tag keys
	TAGKEYS(                XK_1,      0)
	TAGKEYS(                XK_2,      1)
	TAGKEYS(                XK_3,      2)
	TAGKEYS(                XK_4,      3)
	TAGKEYS(                XK_5,      4)
	TAGKEYS(                XK_6,      5)
	TAGKEYS(                XK_7,      6)
	TAGKEYS(                XK_8,      7)
	TAGKEYS(                XK_9,      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	
	// { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	// { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	// { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
};

