#!/usr/bin/env python3
"""
Test script to verify all clickable elements on the architecture page
"""
import requests
from bs4 import BeautifulSoup
import os

def test_architecture_links():
    """Test all links on the architecture page"""
    base_url = "http://localhost:8082"
    architecture_url = f"{base_url}/architecture.html"

    try:
        # Get the architecture page
        response = requests.get(architecture_url)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')

        print("🔍 Testing Architecture Page Links")
        print("=" * 50)

        # Test header navigation links
        print("\n📋 Header Navigation Links:")
        header_links = soup.select('.nav-link')
        for link in header_links:
            href = link.get('href')
            if href and not href.startswith('#'):
                full_url = f"{base_url}/{href}" if not href.startswith('http') else href
                try:
                    link_response = requests.head(full_url, timeout=5)
                    status = "✅" if link_response.status_code == 200 else "❌"
                    print(f"  {status} {href}")
                except:
                    print(f"  ❌ {href} (connection error)")

        # Test sidebar navigation tiles
        print("\n🗂️ Sidebar Navigation Tiles:")
        sidebar_links = soup.select('.nav-tile')
        for link in sidebar_links:
            href = link.get('href')
            if href and not href.startswith('#') and not href.startswith('javascript'):
                full_url = f"{base_url}/{href}" if not href.startswith('http') else href
                try:
                    link_response = requests.head(full_url, timeout=5)
                    status = "✅" if link_response.status_code == 200 else "❌"
                    text = link.select_one('.nav-tile-text')
                    link_text = text.text if text else href
                    print(f"  {status} {link_text}")
                except:
                    text = link.select_one('.nav-tile-text')
                    link_text = text.text if text else href
                    print(f"  ❌ {link_text} (connection error)")

        # Test cloud solution cards
        print("\n☁️ Cloud Solution Cards:")
        cloud_cards = soup.select('.cloud-card')
        for card in cloud_cards:
            onclick = card.get('onclick')
            if onclick and 'location.href' in onclick:
                href = onclick.split("'")[1]
                full_url = f"{base_url}/{href}" if not href.startswith('http') else href
                try:
                    link_response = requests.head(full_url, timeout=5)
                    status = "✅" if link_response.status_code == 200 else "❌"
                    title = card.select_one('.cloud-title')
                    card_text = title.text if title else href
                    print(f"  {status} {card_text}")
                except:
                    title = card.select_one('.cloud-title')
                    card_text = title.text if title else href
                    print(f"  ❌ {card_text} (connection error)")

        # Test diagram links
        print("\n📊 Diagram Links:")
        diagram_links = soup.select('.diagram-link')
        for link in diagram_links:
            href = link.get('href')
            if href and not href.startswith('#'):
                full_url = f"{base_url}/{href}" if not href.startswith('http') else href
                try:
                    link_response = requests.head(full_url, timeout=5)
                    status = "✅" if link_response.status_code == 200 else "❌"
                    print(f"  {status} {link.text.strip()}")
                except:
                    print(f"  ❌ {link.text.strip()} (connection error)")

        # Test footer social links
        print("\n🔗 Footer Social Links:")
        social_links = soup.select('.social-link')
        for link in social_links:
            href = link.get('href')
            if href:
                try:
                    link_response = requests.head(href, timeout=5)
                    status = "✅" if link_response.status_code == 200 else "⚠️"
                    print(f"  {status} {link.text.strip()}")
                except:
                    print(f"  ⚠️ {link.text.strip()} (connection error)")

        # Test images
        print("\n🖼️ Architectural Images:")
        images = soup.select('.diagram-image')
        for img in images:
            src = img.get('src')
            if src:
                full_url = f"{base_url}/{src}" if not src.startswith('http') else src
                try:
                    img_response = requests.head(full_url, timeout=5)
                    status = "✅" if img_response.status_code == 200 else "❌"
                    alt = img.get('alt', src)
                    print(f"  {status} {alt}")
                except:
                    alt = img.get('alt', src)
                    print(f"  ❌ {alt} (connection error)")

        print("\n" + "=" * 50)
        print("🎉 Link testing completed!")

    except Exception as e:
        print(f"❌ Error testing architecture page: {e}")

if __name__ == "__main__":
    test_architecture_links()
