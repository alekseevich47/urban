// ========================================
// АНИМАЦИЯ РИСОВАНИЯ ИКОНОК НА CANVAS
// ========================================
const canvas = document.getElementById('icons-canvas');
const ctx = canvas.getContext('2d');

// Установка размеров canvas
function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
}
resizeCanvas();
window.addEventListener('resize', resizeCanvas);

// SVG пути для иконок развлечений
const iconPaths = {
    // Маска (театр)
    mask: 'M50 30 C20 30 10 50 10 70 C10 90 30 100 50 100 C70 100 90 90 90 70 C90 50 80 30 50 30 Z M30 60 C30 55 35 50 40 50 C45 50 50 55 50 60 C50 65 45 70 40 70 C35 70 30 65 30 60 Z M60 60 C60 55 65 50 70 50 C75 50 80 55 80 60 C80 65 75 70 70 70 C65 70 60 65 60 60 Z M45 85 Q50 90 55 85',
    // Велосипед
    bicycle: 'M30 70 C30 85 45 100 60 100 C75 100 90 85 90 70 C90 55 75 40 60 40 C45 40 30 55 30 70 Z M10 70 C10 85 25 100 40 100 C55 100 70 85 70 70 C70 55 55 40 40 40 C25 40 10 55 10 70 Z M40 40 L55 25 L70 30 L65 50 M55 25 L45 15 L35 20',
    // Мяч (футбольный)
    ball: 'M50 10 C28 10 10 28 10 50 C10 72 28 90 50 90 C72 90 90 72 90 50 C90 28 72 10 50 10 Z M50 25 L55 40 L70 40 L58 50 L62 65 L50 55 L38 65 L42 50 L30 40 L45 40 Z',
    // Книга
    book: 'M20 30 L20 90 L45 90 L45 35 L20 30 Z M45 35 L70 30 L70 90 L45 90',
    // Музыкальная нота
    musicNote: 'M40 20 L40 80 C40 85 45 90 50 90 C55 90 60 85 60 80 L60 35 L80 30 L80 20 Z',
    // Кино ( popcorn )
    popcorn: 'M30 40 L25 90 L75 90 L70 40 Z M30 40 C30 30 40 25 50 25 C60 25 70 30 70 40',
    // Палитра (искусство)
    palette: 'M50 20 C30 20 15 35 15 55 C15 75 35 85 50 85 C70 85 85 75 85 55 C85 35 70 20 50 20 Z M35 50 C35 53 38 55 40 55 C42 55 45 53 45 50 C45 47 42 45 40 45 C38 45 35 47 35 50 Z M60 45 C60 48 63 50 65 50 C68 50 70 48 70 45 C70 42 68 40 65 40 C63 40 60 42 60 45 Z M55 65 C55 68 58 70 60 70 C63 70 65 68 65 65 C65 62 63 60 60 60 C58 60 55 62 55 65 Z M40 65 C40 68 43 70 45 70 C48 70 50 68 50 65 C50 62 48 60 45 60 C43 60 40 62 40 65 Z',
    // Геймпад
    gamepad: 'M20 50 C20 35 35 25 50 25 C65 25 80 35 80 50 C80 65 65 75 50 75 C35 75 20 65 20 50 Z M30 45 L35 45 L30 50 L35 55 L30 55 L25 50 Z M65 45 C65 48 68 50 70 50 C72 50 75 48 75 45 C75 42 72 40 70 40 C68 40 65 42 65 45 Z M60 55 C60 58 63 60 65 60 C68 60 70 58 70 55 C70 52 68 50 65 50 C63 50 60 52 60 55 Z',
    // Сердце
    heart: 'M50 85 C20 60 10 45 10 35 C10 20 25 15 35 20 C45 25 50 35 50 35 C50 35 55 25 65 20 C75 15 90 20 90 35 C90 45 80 60 50 85 Z',
    // Звезда
    star: 'M50 15 L60 35 L80 35 L65 50 L70 70 L50 60 L30 70 L35 50 L20 35 L40 35 Z',
    // Солнце
    sun: 'M50 25 L50 15 M50 85 L50 75 M25 50 L15 50 M85 50 L75 50 M32 32 L25 25 M75 75 L68 68 M32 68 L25 75 M75 25 L68 32 M50 35 C40 35 35 40 35 50 C35 60 40 65 50 65 C60 65 65 60 65 50 C65 40 60 35 50 35 Z',
    // Луна
    moon: 'M50 20 C30 20 15 35 15 55 C15 75 30 90 50 90 C65 90 78 80 82 65 C70 70 60 65 60 50 C60 35 70 25 82 30 C78 20 65 20 50 20 Z',
    // Подарок
    gift: 'M30 40 L30 90 L70 90 L70 40 Z M50 40 L50 90 M20 45 L80 45 M50 40 C50 30 40 25 35 25 C30 25 25 30 25 40 M50 40 C50 30 60 25 65 25 C70 25 75 30 75 40',
    // Ракета
    rocket: 'M50 10 C40 20 35 40 35 55 L35 75 L25 85 L35 85 L35 95 L65 95 L65 85 L75 85 L65 75 L65 55 C65 40 60 20 50 10 Z M50 35 C47 35 45 37 45 40 C45 43 47 45 50 45 C53 45 55 43 55 40 C55 37 53 35 50 35 Z',
    // Лампочка (идея)
    lightbulb: 'M50 15 C35 15 25 30 25 45 C25 55 30 60 35 65 L35 75 L65 75 L65 65 C70 60 75 55 75 45 C75 30 65 15 50 15 Z M40 80 L60 80 L60 85 L40 85 Z',
    // Камера
    camera: 'M20 40 L25 35 L75 35 L80 40 L80 75 L20 75 Z M50 45 C40 45 35 52 35 60 C35 68 40 75 50 75 C60 75 65 68 65 60 C65 52 60 45 50 45 Z M70 40 L73 37 L78 40',
    // Дерево (природа)
    tree: 'M50 15 L35 40 L45 40 L30 65 L45 65 L25 90 L75 90 L55 65 L70 65 L55 40 L65 40 Z M45 90 L55 90 L55 100 L45 100 Z',
    // Дом
    house: 'M50 15 L20 40 L20 90 L80 90 L80 40 Z M50 15 L80 40 M40 90 L40 70 L60 70 L60 90',
    // Ключ
    key: 'M50 30 C40 30 35 35 35 45 C35 55 40 60 50 60 C55 60 60 58 65 55 L75 65 L75 55 L85 55 L85 45 L75 45 L75 35 L65 45 C60 40 55 30 50 30 Z M50 40 C53 40 55 42 55 45 C55 48 53 50 50 50 C47 50 45 48 45 45 C45 42 47 40 50 40 Z',
    // Часы
    clock: 'M50 15 C30 15 15 30 15 50 C15 70 30 85 50 85 C70 85 85 70 85 50 C85 30 70 15 50 15 Z M50 35 L50 50 L65 55 M50 50 L50 65'
};

// Массив иконок для отображения
const iconsList = Object.keys(iconPaths);

// Параметры для анимации
let drawnIcons = [];
let animationProgress = 0;
let currentIconIndex = 0;
let iconAnimationComplete = false;

// Функция рисования пути с анимацией
function drawPath(pathData, progress, x, y, scale, color, lineWidth) {
    if (!pathData || progress <= 0) return;
    
    ctx.beginPath();
    ctx.strokeStyle = color;
    ctx.lineWidth = lineWidth;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    
    // Парсинг SVG пути
    const commands = pathData.match(/[A-Z][^A-Z]*/g);
    if (!commands) return;
    
    let currentX = 0;
    let currentY = 0;
    let startX = 0;
    let startY = 0;
    let totalLength = 0;
    let lengths = [];
    
    // Вычисляем общую длину пути
    for (let cmd of commands) {
        const type = cmd[0];
        const coords = cmd.slice(1).trim().split(/[\s,]+/).map(Number);
        
        if (type === 'M' || type === 'L') {
            const [nx, ny] = coords;
            if (type === 'M') {
                startX = nx;
                startY = ny;
                currentX = nx;
                currentY = ny;
            } else {
                const dx = nx - currentX;
                const dy = ny - currentY;
                totalLength += Math.sqrt(dx * dx + dy * dy);
                currentX = nx;
                currentY = ny;
            }
        } else if (type === 'C') {
            const [x1, y1, x2, y2, x3, y3] = coords;
            // Приблизительная длина кривой Безье
            const length = Math.abs(x3 - currentX) + Math.abs(y3 - currentY);
            totalLength += length * 0.7;
            currentX = x3;
            currentY = y3;
        } else if (type === 'Q') {
            const [x1, y1, x2, y2] = coords;
            const length = Math.abs(x2 - currentX) + Math.abs(y2 - currentY);
            totalLength += length * 0.8;
            currentX = x2;
            currentY = y2;
        } else if (type === 'Z') {
            const dx = startX - currentX;
            const dy = startY - currentY;
            totalLength += Math.sqrt(dx * dx + dy * dy);
            currentX = startX;
            currentY = startY;
        }
    }
    
    // Рисуем путь до определённого прогресса
    let drawnLength = 0;
    const targetLength = totalLength * progress;
    currentX = 0;
    currentY = 0;
    
    for (let i = 0; i < commands.length && drawnLength < targetLength; i++) {
        const cmd = commands[i];
        const type = cmd[0];
        const coords = cmd.slice(1).trim().split(/[\s,]+/).map(Number);
        
        if (type === 'M') {
            const [nx, ny] = coords;
            currentX = nx * scale + x;
            currentY = ny * scale + y;
            ctx.moveTo(currentX, currentY);
            startX = currentX;
            startY = currentY;
        } else if (type === 'L') {
            const [nx, ny] = coords;
            const nextX = nx * scale + x;
            const nextY = ny * scale + y;
            const segmentLength = Math.sqrt((nextX - currentX) ** 2 + (nextY - currentY) ** 2);
            
            if (drawnLength + segmentLength <= targetLength) {
                ctx.lineTo(nextX, nextY);
                currentX = nextX;
                currentY = nextY;
                drawnLength += segmentLength;
            } else {
                const remaining = targetLength - drawnLength;
                const ratio = remaining / segmentLength;
                const partialX = currentX + (nextX - currentX) * ratio;
                const partialY = currentY + (nextY - currentY) * ratio;
                ctx.lineTo(partialX, partialY);
                currentX = partialX;
                currentY = partialY;
                drawnLength = targetLength;
            }
        } else if (type === 'C') {
            const [x1, y1, x2, y2, x3, y3] = coords;
            const endX = x3 * scale + x;
            const endY = y3 * scale + y;
            const segmentLength = Math.abs(endX - currentX) + Math.abs(endY - currentY);
            
            if (drawnLength + segmentLength * 0.7 <= targetLength) {
                ctx.bezierCurveTo(
                    x1 * scale + x, y1 * scale + y,
                    x2 * scale + x, y2 * scale + y,
                    endX, endY
                );
                currentX = endX;
                currentY = endY;
                drawnLength += segmentLength * 0.7;
            } else {
                const remaining = targetLength - drawnLength;
                const t = Math.min(1, remaining / (segmentLength * 0.7));
                // Упрощённая интерполяция кривой
                const partialX = currentX + (endX - currentX) * t;
                const partialY = currentY + (endY - currentY) * t;
                ctx.lineTo(partialX, partialY);
                currentX = partialX;
                currentY = partialY;
                drawnLength = targetLength;
            }
        } else if (type === 'Q') {
            const [x1, y1, x2, y2] = coords;
            const endX = x2 * scale + x;
            const endY = y2 * scale + y;
            const segmentLength = Math.abs(endX - currentX) + Math.abs(endY - currentY);
            
            if (drawnLength + segmentLength * 0.8 <= targetLength) {
                ctx.quadraticCurveTo(
                    x1 * scale + x, y1 * scale + y,
                    endX, endY
                );
                currentX = endX;
                currentY = endY;
                drawnLength += segmentLength * 0.8;
            } else {
                const remaining = targetLength - drawnLength;
                const t = Math.min(1, remaining / (segmentLength * 0.8));
                const partialX = currentX + (endX - currentX) * t;
                const partialY = currentY + (endY - currentY) * t;
                ctx.lineTo(partialX, partialY);
                currentX = partialX;
                currentY = partialY;
                drawnLength = targetLength;
            }
        } else if (type === 'Z') {
            const segmentLength = Math.sqrt((startX - currentX) ** 2 + (startY - currentY) ** 2);
            if (drawnLength + segmentLength <= targetLength) {
                ctx.closePath();
                currentX = startX;
                currentY = startY;
                drawnLength += segmentLength;
            } else {
                const remaining = targetLength - drawnLength;
                const ratio = remaining / segmentLength;
                const partialX = currentX + (startX - currentX) * ratio;
                const partialY = currentY + (startY - currentY) * ratio;
                ctx.lineTo(partialX, partialY);
                currentX = partialX;
                currentY = partialY;
                drawnLength = targetLength;
            }
        }
    }
    
    ctx.stroke();
}

// Позиции для иконок (распределяем по экрану)
function getIconPositions() {
    const positions = [];
    const cols = 5;
    const rows = 4;
    const padding = 80;
    
    const availableWidth = canvas.width - padding * 2;
    const availableHeight = canvas.height - padding * 2;
    
    const stepX = availableWidth / (cols - 1);
    const stepY = availableHeight / (rows - 1);
    
    for (let i = 0; i < Math.min(iconsList.length, cols * rows); i++) {
        const col = i % cols;
        const row = Math.floor(i / cols);
        
        // Добавляем случайное смещение для естественности
        const offsetX = (Math.random() - 0.5) * 40;
        const offsetY = (Math.random() - 0.5) * 40;
        
        positions.push({
            x: padding + col * stepX + offsetX,
            y: padding + row * stepY + offsetY,
            scale: 0.6 + Math.random() * 0.3,
            rotation: (Math.random() - 0.5) * 0.3,
            icon: iconsList[i]
        });
    }
    
    return positions;
}

let iconPositions = [];

// Инициализация позиций при загрузке
function initIconPositions() {
    iconPositions = getIconPositions();
}

// Анимация рисования иконок
function animateIcons() {
    if (iconAnimationComplete) return;
    
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    // Градиентные цвета для иконок
    const colors = [
        'rgba(102, 126, 234, 0.6)',
        'rgba(118, 75, 162, 0.6)',
        'rgba(240, 147, 251, 0.6)',
        'rgba(79, 172, 254, 0.6)',
        'rgba(67, 233, 123, 0.6)'
    ];
    
    // Рисуем уже завершённые иконки
    drawnIcons.forEach(icon => {
        ctx.save();
        ctx.translate(icon.x, icon.y);
        ctx.rotate(icon.rotation);
        ctx.translate(-icon.x, -icon.y);
        
        drawPath(
            iconPaths[icon.icon],
            1,
            icon.x,
            icon.y,
            icon.scale,
            icon.color,
            2
        );
        
        ctx.restore();
    });
    
    // Рисуем текущую иконку в процессе рисования
    if (currentIconIndex < iconPositions.length) {
        const pos = iconPositions[currentIconIndex];
        
        ctx.save();
        ctx.translate(pos.x, pos.y);
        ctx.rotate(pos.rotation);
        ctx.translate(-pos.x, -pos.y);
        
        drawPath(
            iconPaths[pos.icon],
            animationProgress,
            pos.x,
            pos.y,
            pos.scale,
            colors[currentIconIndex % colors.length],
            2
        );
        
        ctx.restore();
    }
    
    // Обновляем прогресс
    animationProgress += 0.015;
    
    if (animationProgress >= 1) {
        // Иконка завершена, переходим к следующей
        if (currentIconIndex < iconPositions.length) {
            drawnIcons.push({
                ...iconPositions[currentIconIndex],
                color: colors[currentIconIndex % colors.length]
            });
        }
        
        currentIconIndex++;
        animationProgress = 0;
        
        if (currentIconIndex >= iconPositions.length) {
            iconAnimationComplete = true;
            // Финальная очистка и перерисовка всех иконок
            setTimeout(() => {
                drawAllIcons();
            }, 100);
            return;
        }
    }
    
    requestAnimationFrame(animateIcons);
}

// Функция для отрисовки всех иконок после завершения анимации
function drawAllIcons() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    const colors = [
        'rgba(102, 126, 234, 0.4)',
        'rgba(118, 75, 162, 0.4)',
        'rgba(240, 147, 251, 0.4)',
        'rgba(79, 172, 254, 0.4)',
        'rgba(67, 233, 123, 0.4)'
    ];
    
    drawnIcons.forEach((icon, index) => {
        ctx.save();
        ctx.translate(icon.x, icon.y);
        ctx.rotate(icon.rotation);
        ctx.translate(-icon.x, -icon.y);
        
        drawPath(
            iconPaths[icon.icon],
            1,
            icon.x,
            icon.y,
            icon.scale,
            colors[index % colors.length],
            1.5
        );
        
        ctx.restore();
    });
}

// Запуск анимации после загрузки страницы
window.addEventListener('load', () => {
    initIconPositions();
    animateIcons();
});

// Перезапуск при изменении размера окна
let resizeTimeout;
window.addEventListener('resize', () => {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(() => {
        resizeCanvas();
        drawnIcons = [];
        currentIconIndex = 0;
        animationProgress = 0;
        iconAnimationComplete = false;
        initIconPositions();
        animateIcons();
    }, 250);
});

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

// Показываем/скрываем курсор в зависимости от устройства
function isMobile() {
    return window.innerWidth <= 768;
}

function initCursor() {
    if (isMobile()) {
        cursor.style.display = 'none';
        cursorFollower.style.display = 'none';
        document.body.style.cursor = 'auto';
        return false;
    } else {
        cursor.style.display = 'block';
        cursorFollower.style.display = 'block';
        document.body.style.cursor = 'none';
        return true;
    }
}

const cursorEnabled = initCursor();

if (cursorEnabled) {
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
}

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
// Курсор уже обрабатывается в initCursor(), здесь только галерея
if (window.innerWidth <= 768) {
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
