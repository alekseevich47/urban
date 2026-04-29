// ========================================
// ИНИЦИАЛИЗАЦИЯ LENIS (ПЛАВНЫЙ СКРОЛЛ)
// ========================================
const lenis = new Lenis({
    duration: 1.2,
    easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
    direction: 'vertical',
    gestureDirection: 'vertical',
    smooth: true,
    mouseMultiplier: 1,
    smoothTouch: false,
    touchMultiplier: 2,
    infinite: false,
});

function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
}

requestAnimationFrame(raf);

// Интеграция Lenis с GSAP ScrollTrigger
gsap.registerPlugin(ScrollTrigger);

lenis.on('scroll', ScrollTrigger.update);

gsap.ticker.add((time) => {
    lenis.raf(time * 1000);
});

gsap.ticker.lagSmoothing(0);

// ========================================
// КАСТОМНЫЙ КУРСОР
// ========================================
const cursor = document.querySelector('.cursor');
const cursorFollower = document.querySelector('.cursor-follower');

let mouseX = 0;
let mouseY = 0;
let followerX = 0;
let followerY = 0;

document.addEventListener('mousemove', (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
    
    // Мгновенное перемещение основного курсора
    cursor.style.left = mouseX + 'px';
    cursor.style.top = mouseY + 'px';
});

// Плавное следование follower
function animateCursor() {
    followerX += (mouseX - followerX) * 0.1;
    followerY += (mouseY - followerY) * 0.1;
    
    cursorFollower.style.left = followerX + 'px';
    cursorFollower.style.top = followerY + 'px';
    
    requestAnimationFrame(animateCursor);
}

animateCursor();

// Эффект курсора при наведении на интерактивные элементы
const interactiveElements = document.querySelectorAll('a, button, input, textarea, .feature-card, .gallery-item');

interactiveElements.forEach(el => {
    el.addEventListener('mouseenter', () => {
        cursor.style.transform = 'translate(-50%, -50%) scale(0.5)';
        cursorFollower.style.transform = 'translate(-50%, -50%) scale(1.5)';
        cursorFollower.style.background = 'rgba(102, 126, 234, 0.3)';
    });
    
    el.addEventListener('mouseleave', () => {
        cursor.style.transform = 'translate(-50%, -50%) scale(1)';
        cursorFollower.style.transform = 'translate(-50%, -50%) scale(1)';
        cursorFollower.style.background = 'rgba(255, 255, 255, 0.1)';
    });
});

// ========================================
// HERO АНИМАЦИИ
// ========================================
const tl = gsap.timeline();

tl.to('.hero-title .line', {
    opacity: 1,
    y: 0,
    duration: 1,
    stagger: 0.2,
    ease: 'power4.out',
})
.to('.hero-subtitle', {
    opacity: 1,
    y: 0,
    duration: 0.8,
    ease: 'power3.out',
}, '-=0.5');

// ========================================
// ПАРАЛЛАКС ЭФФЕКТЫ
// ========================================

// Плавающие элементы в hero секции
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const floatElements = document.querySelectorAll('.float-element');
    
    floatElements.forEach(el => {
        const speed = el.getAttribute('data-speed');
        el.style.transform = `translateY(${scrolled * speed}px)`;
    });
});

// Параллакс слои в features секции
gsap.utils.toArray('.parallax-layer').forEach(layer => {
    const speed = layer.getAttribute('data-speed');
    
    gsap.to(layer, {
        y: () => ScrollTrigger.maxScroll(window) * speed,
        ease: 'none',
        scrollTrigger: {
            trigger: '.features',
            start: 'top bottom',
            end: 'bottom top',
            scrub: 0,
        },
    });
});

// ========================================
// SCROLL-DRIVEN АНИМАЦИИ
// ========================================

// About секция - анимация статистики
const statNumbers = document.querySelectorAll('.stat-number');

statNumbers.forEach(stat => {
    const target = parseInt(stat.getAttribute('data-target'));
    
    ScrollTrigger.create({
        trigger: stat,
        start: 'top 80%',
        once: true,
        onEnter: () => {
            gsap.to(stat, {
                innerHTML: target,
                duration: 2,
                snap: { innerHTML: 1 },
                ease: 'power2.out',
                modifiers: {
                    innerHTML: value => Math.floor(value)
                }
            });
        },
    });
});

// Features секция - появление карточек
gsap.utils.toArray('.feature-card').forEach((card, index) => {
    gsap.to(card, {
        opacity: 1,
        y: 0,
        duration: 0.8,
        delay: index * 0.1,
        ease: 'power3.out',
        scrollTrigger: {
            trigger: card,
            start: 'top 85%',
            toggleActions: 'play none none reverse',
        },
    });
});

// Gallery секция - горизонтальный скролл
const galleryTrack = document.querySelector('.gallery-track');
const galleryItems = document.querySelectorAll('.gallery-item');

// Анимация появления элементов галереи
galleryItems.forEach((item, index) => {
    gsap.to(item, {
        opacity: 1,
        x: 0,
        duration: 0.8,
        delay: index * 0.15,
        ease: 'power3.out',
        scrollTrigger: {
            trigger: item,
            start: 'top 85%',
            toggleActions: 'play none none reverse',
        },
    });
});

// Горизонтальная прокрутка галереи при вертикальном скролле
if (window.innerWidth > 768) {
    gsap.to(galleryTrack, {
        x: () => -(galleryTrack.scrollWidth - window.innerWidth + 400),
        ease: 'none',
        scrollTrigger: {
            trigger: '.gallery',
            start: 'top top',
            end: () => '+=' + galleryTrack.scrollWidth,
            pin: true,
            scrub: 1,
            invalidateOnRefresh: true,
        },
    });
}

// ========================================
// НАВИГАЦИЯ
// ========================================
const navbar = document.querySelector('.navbar');

ScrollTrigger.create({
    start: 'top -80',
    end: 99999,
    toggleClass: {
        className: 'scrolled',
        targets: navbar,
    },
});

// Плавный скролл к якорям
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        
        if (target) {
            lenis.scrollTo(target, {
                offset: -80,
                duration: 1.5,
            });
        }
    });
});

// ========================================
// ФОРМА КОНТАКТОВ
// ========================================
const contactForm = document.querySelector('.contact-form');

contactForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Анимация отправки
    const submitButton = contactForm.querySelector('.submit-button');
    const originalText = submitButton.textContent;
    
    submitButton.textContent = 'Отправлено! ✓';
    submitButton.style.background = 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)';
    
    setTimeout(() => {
        submitButton.textContent = originalText;
        submitButton.style.background = '';
        contactForm.reset();
    }, 3000);
});

// ========================================
// ДОПОЛНИТЕЛЬНЫЕ ЭФФЕКТЫ
// ========================================

// Эффект появления текста при скролле
const textElements = document.querySelectorAll('.about-text p, .section-title, .section-tag');

textElements.forEach(el => {
    gsap.fromTo(el, 
        { opacity: 0, y: 30 },
        {
            opacity: 1,
            y: 0,
            duration: 0.8,
            ease: 'power3.out',
            scrollTrigger: {
                trigger: el,
                start: 'top 85%',
                toggleActions: 'play none none reverse',
            },
        }
    );
});

// Эффект масштабирования для stat-item при наведении
const statItems = document.querySelectorAll('.stat-item');

statItems.forEach(item => {
    item.addEventListener('mouseenter', () => {
        gsap.to(item, {
            scale: 1.05,
            duration: 0.3,
            ease: 'power2.out',
        });
    });
    
    item.addEventListener('mouseleave', () => {
        gsap.to(item, {
            scale: 1,
            duration: 0.3,
            ease: 'power2.out',
        });
    });
});

// ========================================
// МОБИЛЬНАЯ ОПТИМИЗАЦИЯ
// ========================================
if (window.innerWidth <= 768) {
    // Отключаем кастомный курсор на мобильных
    cursor.style.display = 'none';
    cursorFollower.style.display = 'none';
    document.body.style.cursor = 'auto';
    
    // Отключаем горизонтальный скролл галереи
    ScrollTrigger.getAll().forEach(trigger => {
        if (trigger.trigger && trigger.trigger.classList.contains('gallery')) {
            trigger.kill();
        }
    });
    
    gsap.set(galleryTrack, { x: 0 });
    ScrollTrigger.refresh();
}

// Обновление ScrollTrigger при изменении размера окна
let resizeTimer;
window.addEventListener('resize', () => {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(() => {
        ScrollTrigger.refresh();
        
        // Пересоздаём горизонтальный скролл для галереи если нужно
        if (window.innerWidth > 768) {
            gsap.to(galleryTrack, {
                x: () => -(galleryTrack.scrollWidth - window.innerWidth + 400),
                ease: 'none',
                scrollTrigger: {
                    trigger: '.gallery',
                    start: 'top top',
                    end: () => '+=' + galleryTrack.scrollWidth,
                    pin: true,
                    scrub: 1,
                    invalidateOnRefresh: true,
                },
            });
        }
    }, 250);
});

console.log('🚀 Urban Project Website Loaded Successfully!');
