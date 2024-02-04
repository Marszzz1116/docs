import { defineConfig } from 'vitepress'
import AutoSidebar from 'vite-plugin-vitepress-auto-sidebar';
import { withMermaid } from "vitepress-plugin-mermaid";
import timeline from "vitepress-markdown-timeline";

// https://vitepress.dev/reference/site-config
export default withMermaid(
  defineConfig({
    head: [
        ['meta', { name: 'referrer', content: 'no-referrer-when-downgrade' }],
    ],
    vite: {
      plugins: [
        // add plugin
        AutoSidebar({
          // You can also set options to adjust sidebar data
          // see option document below
          prefix: '.', collapsed: true
        })
      ]
    },
    markdown: {
      config: (md) =>{
        md.use(timeline)
      }
    },
    base: '/docs/',
    lang: 'zh-CN',
    title: "Funny Docs",
    description: "有趣的知识库",
    themeConfig: {
      // https://vitepress.dev/reference/default-theme-config
      nav: [
        { text: '自动化技术', link: '/自动化技术/自动化测试框架/Pytest从入门到起飞' },
        { text: '网络爬虫', link: '/网络爬虫/接口请求工具/Requests' },
        { text: '前后端', link: '/前后端/前端/Linux上安装Nodejs' },
        { text: '人工智能', link: '/人工智能/图像/MMDetection入门基础' },
        { text: '编程语言', items:[
                {text:'Python', link: '/编程语言/Python/Linux上如何选择用pip3还是sudopip3'},
                {text:'Shell', link: '/编程语言/Shell/index.md'},
            ]
        },
        { text: 'Linux', link: '/Linux/方案教程/Linux基础' },
        { text: '技术文档', link: '/技术文档/专利交底书/一种定位目标图片坐标的图像识别技术交底书' },
        { text: '规范文档', link: '/规范文档/流程规范/测试单驱动自动化' },
        { text: '读书笔记', link: '/读书笔记/OpenStack系统架构设计实战' },
        { text: '常见问题', link: '/常见问题/Wayland下sniff报错' },
        { text: '🍀 更多', items:[
            { text: '💬 留言', link: '/comments' },
            { text: '📝 投稿', link: '/投稿' },
            { text: '💯 关于', link: '/about' },
            ]
        },
      ],
      search: {
        provider: 'local'
      },
      ignoreDeadLinks: true,
      // =========================================================
      logo: { src: '/vitepress-logo-mini.svg', width: 24, height: 24 },
      socialLinks: [
        { icon: 'github', link: 'https://github.com/mikigo/docs' }
      ],
      footer: {
        copyright: `版权所有 © 2023-${new Date().getFullYear()} 统信软件`
      },
      //大纲显示2-3级标题
      outline:[2,4],
      //大纲顶部标题
      outlineTitle:'当前页大纲',

      docFooter: {
        prev: '上一页',
        next: '下一页'
      },

      lastUpdated: {
        text: '最后更新于',
        formatOptions: {
          dateStyle: 'short',
          timeStyle: 'medium'
        }
      },

      langMenuLabel: '多语言',
      returnToTopLabel: '回到顶部',
      sidebarMenuLabel: '菜单',
      darkModeSwitchLabel: '主题',
      lightModeSwitchTitle: '切换到浅色模式',
      darkModeSwitchTitle: '切换到深色模式'
    },
  })
);
