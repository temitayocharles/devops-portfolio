// Page loader and resource error handling
document.addEventListener('DOMContentLoaded', function() {
    // Add loading class to body
    document.body.classList.add('loading');
    
    // Remove loading class when page is fully loaded
    window.addEventListener('load', function() {
        document.body.classList.remove('loading');
    });
    
    // Handle missing images
    document.querySelectorAll('img').forEach(img => {
        img.addEventListener('error', function() {
            // If the image is in the demos folder
            if (this.src.includes('/demos/')) {
                this.parentElement.innerHTML = `
                    <div style="
                        background: #1a1a1a;
                        height: 200px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        flex-direction: column;
                        color: #66d9ef;
                        border-radius: 8px;
                    ">
                        <div style="font-size: 2rem; margin-bottom: 10px;">🎬</div>
                        <div>Demo Coming Soon</div>
                    </div>
                `;
            } else {
                // For other images, replace with a placeholder
                const text = this.alt || 'Image';
                this.src = `https://via.placeholder.com/400x300/1a1a1a/66d9ef?text=${encodeURIComponent(text)}`;
            }
        });
    });
    
    // Handle missing video content
    document.querySelectorAll('video').forEach(video => {
        video.addEventListener('error', function() {
            this.outerHTML = `
                <div style="
                    background: #1a1a1a;
                    height: 300px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    flex-direction: column;
                    color: #66d9ef;
                    border-radius: 8px;
                ">
                    <div style="font-size: 2rem; margin-bottom: 10px;">🎥</div>
                    <div>Video Coming Soon</div>
                </div>
            `;
        });
    });
});
