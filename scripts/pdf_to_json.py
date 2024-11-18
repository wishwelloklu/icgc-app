import fitz
import json
import re

pdf_path = "../assets/pdf/naming_ceremony.pdf"
json_path = "../assets/json/naming_ceremony.json"

#[Names of the Child]
#[name of the child]
#[The father then announces the names to those present and explains the meaning of the names]
#[Name of father]
#[name of child’s parents]
#[Name of child]
#[name of child]

def pdf_to_json_with_titles_and_bold(pdf_path, json_path,footer_threshold=60):
    pdf_document = fitz.open(pdf_path)
    pdf_data = []

    for page_num in range(pdf_document.page_count):
        page = pdf_document[page_num]
        page_height = page.rect.height 
        page_width = page.rect.width  # Get page width for centered text detection
        page_data = {
            "page_number": page_num + 1,
            "title": None,
            "content": ""
        }
        # Regular expression to match numbered subtitles (e.g., "1. Opening Prayer")

        name_patterns = {
        "*nc": re.compile(r"\[(Names? of the Child|name of the child|Name of child|name of child)\]", re.IGNORECASE),
        "*fn": re.compile(r"\[(Name of father)\]", re.IGNORECASE),
        "*pr": re.compile(r"\[(name of child’s parents)\]", re.IGNORECASE)
        }

        alphabetical_bulletin_pattern = re.compile(r"^[a-zA-Z]\.\s+.*")
        numbered_entry_pattern = re.compile(r"^\d+(\.\d+)?\.\s+.*\s+\d+$")
        numbered_bulletin_pattern = re.compile(r"^\d+\.\s+.*") 
        # Extract text blocks with font information
        blocks = page.get_text("dict")["blocks"]


        # Analyze blocks to determine if a block is likely a title
        for block in blocks:
            if "lines" not in block:
                continue

            if block["bbox"][1] > page_height - footer_threshold:
                continue
            
            for line in block["lines"]:
                for span in line["spans"]:
                    text = span["text"].strip()
                    font_size = span["size"]
                    y_position = block["bbox"][1]
                    font_flags = span["flags"]  # Font style information
                    x_position = span["bbox"][0]
                    is_bold = font_flags & 2 ** 4  # Common flag for bold text in PyMuPDF
                    is_italic = font_flags & 2 ** 1  # Common flag for italic text in PyMuPDF 
                    # Detect centered text by checking if the span is near the center of the page width
                    is_centered = abs((x_position + span["bbox"][2]) / 2 - page_width / 2) < page_width * 0.
                    
                    is_numbered_entry = numbered_entry_pattern.match(text) is not None
                    # Format title (if no title has been set and it's a likely title candidate)
                    if font_size > 12 and y_position < 100 and len(text) > 5:
                        if not page_data["title"]:
                            page_data["title"] = text

                    # Format bold text with *b...*b markers
                    formatted_text = text
                    # Wrap specific phrases with tags
                    for tag, pattern in name_patterns.items():
                        if pattern.search(text):
                            text = f"{tag}{text}{tag}"
                            break

                    # Check if text matches the numbered subtitle pattern
                    is_numbered_bulletin = numbered_bulletin_pattern.match(text) is not None
                    is_alphabetical_bulletin = alphabetical_bulletin_pattern.match(text) is not None

                    formatted_text = text
                    if is_bold:
                        formatted_text = f"*b{formatted_text}*b"
                    if is_italic:
                        formatted_text = f"\n*t{formatted_text}*t\n"

                    if is_centered:
                        formatted_text = f"\n{formatted_text}\n"
                    
                    # If it's a numbered or alphabetical bulletin, place it on a new line
                    if is_alphabetical_bulletin:
                        formatted_text = f"\n{formatted_text}\n"

                    if is_numbered_bulletin:
                        formatted_text = f"*b{formatted_text}*b"
                    
                    # Wrap numbered TOC entries in *tc
                    if is_numbered_entry:
                        formatted_text = f"*cc{formatted_text}*cc\n"

                    page_data["content"] += formatted_text + " "
        
        # Append page data to the list
        pdf_data.append(page_data)

    # Save to JSON file
    with open(json_path, 'w', encoding='utf-8') as json_file:
        json.dump(pdf_data, json_file, ensure_ascii=False, indent=4)
    
    print(f"PDF converted to JSON with title and bold formatting, saved to {json_path}")

pdf_to_json_with_titles_and_bold(pdf_path, json_path)
