---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: Funny Docs
  text: "专注于测试方向有趣的知识库"
  tagline: 记录、分享、成长！
  actions:
    - theme: brand
      text: 快速浏览
      link: /自动化技术/自动化测试框架/Pytest从入门到起飞
    - theme: brand
      text: 关于
      link: /about.md
    - theme: alt
      text: 投稿
      link: /投稿.md
    - theme: alt
      text: 留言
      link: /comments.md
  image:
      src: /vitepress-logo-large.webp
      alt: VitePress

features:
  - icon: 📝
    title: 记录
    details: 用热情的笔触描绘生活的点点滴滴，记录下我们共同成长的足迹。
  - icon: 💡
    title: 分享
    details: 让知识的火花在分享中绽放，点燃我们追求卓越的热情。
  - icon: 🚀
    title: 成长
    details: 拥抱成长的旅程，让热情的阳光照耀我们不断前行的道路。
---

<style>
:root {
  --vp-home-hero-name-color: transparent;
  --vp-home-hero-name-background: -webkit-linear-gradient(120deg, #bd34fe 30%, #41d1ff);

  --vp-home-hero-image-background-image: linear-gradient(-45deg, #bd34fe 50%, #47caff 50%);
  --vp-home-hero-image-filter: blur(44px);
}

@media (min-width: 640px) {
  :root {
    --vp-home-hero-image-filter: blur(56px);
  }
}

@media (min-width: 960px) {
  :root {
    --vp-home-hero-image-filter: blur(68px);
  }
}
</style>