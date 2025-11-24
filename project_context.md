# 📦 Project Context – AI Comedy Club (MVP)

## 1️⃣ Project Overview
- **ชื่อโปรเจกต์:** AI Comedy Club  
- **ประเภท:** Mobile app (Flutter) + Backend (Python FastAPI + Google ADK)  
- **เป้าหมายหลัก:** ให้ผู้ใช้ใส่หัวข้อแล้วรับมุกตลกจาก Gemini‑based LlmAgent (หลายภาษา)

## 2️⃣ Architecture Snapshot
```
Flutter (Web / Android / iOS)
   ↕  HTTP (REST + SSE)
FastAPI (uvicorn) – ADK wrapper
   ↕  Gemini‑1.5‑flash / Gemini‑2.5‑flash
```
- **Backend folder:** `backend/joke_agent/agent.py` (exposes `root_agent = joker_agent`)
- **Endpoint flow:**
  1. `GET /list‑apps` → ดึงชื่อ Agent (`joke_agent`)
  2. `POST /apps/{agent}/users/{uid}/sessions/{sid}` → สร้าง Session
  3. `POST /run_sse` → ส่งข้อความผู้ใช้ → รับ SSE (`data: {...}`) → Flutter แยก `content.parts[0].text`

## 3️⃣ Tech Stack
| Layer | Tech | Version / Note |
|-------|------|----------------|
| Frontend | Flutter (Dart) | Web (Chrome) + Android emulator |
| Backend | Python 3.12 | FastAPI, uvicorn |
| Agent | Google ADK (`google‑adk`) | `LlmAgent` with `instruction` field |
| Model | Gemini‑2.5‑flash (fallback Gemini‑1.5‑flash) |
| DevOps | Git, .gitignore, GitHub Actions (planned) |
| CI/CD (future) | Cloud Run / GKE (Google Cloud) |

## 4️⃣ Key Decisions & Rationale
- **ใช้ ADK Built‑in FastAPI** – ลดโค้ด boilerplate, auto‑expose agents.
- **Agent implementation:** `LlmAgent` + `instruction` (single field) + `prompt_template`‑style text → ทำให้สามารถกำหนด “ตอบในภาษาของผู้ใช้” ได้ง่าย.
- **SSE response parsing** – ทำใน Flutter (`AdkService.sendMessage`) เพื่อแยกข้อความจาก `data:` prefix.
- **Folder structure:** `backend/joke_agent/` เพื่อให้ ADK โหลดได้ (ต้องมี `root_agent`).
- **Version control hygiene:** `.gitignore` ครอบคลุม Python, Flutter, Android/iOS, ADK artifacts.

## 5️⃣ Lessons Learned (สรุปจาก Retrospective)
1. **อ่านเอกสาร ADK ก่อนเริ่ม** – API เปลี่ยนบ่อย; `LlmAgent` ใช้ `instruction` แทน `instructions`.
2. **ต้อง export `root_agent`** – ไม่เช่นนั้น ADK จะบอก “No root_agent found”.
3. **ตรวจสอบรูปแบบ SSE** – `data:` prefix ต้องตัดก่อน `jsonDecode`.
4. **เพิ่มฟิลด์ “respond in same language”** – ทำให้ Agent ปรับภาษาอัตโนมัติ.
5. **ตั้ง .gitignore ตั้งแต่ต้น** – ป้องกันไฟล์ virtual‑env, build artifacts ถูก commit.

## 6️⃣ Open Items / Next‑step Ideas
- **Voice output** – เพิ่ม Text‑to‑Speech (flutter_tts) เพื่อให้มุกพูดออกมา.
- **หลาย Persona** – สร้างหลาย Agent (Dad‑jokes, Dark‑humor) ให้ผู้ใช้เลือก.
- **Persisted chat history** – SQLite หรือ Hive ใน Flutter เพื่อบันทึกบทสนทนา.
- **UI polish** – Noto Thai fonts, dark‑mode, micro‑animations.
- **CI/CD pipeline** – GitHub Actions รัน unit test ของ FastAPI + Flutter widget test.
- **Production deployment** – Deploy FastAPI + ADK ไป Cloud Run / GKE, ตั้ง HTTPS, ใช้ Cloud‑run‑auth.

## 7️⃣ How to Re‑use This Context
1. **Copy** `PROJECT_CONTEXT.md` ไปยังโฟลเดอร์ของโปรเจกต์ใหม่.
2. **ปรับ**ส่วน “Project Overview”, “Goals”, “Tech Stack” ให้สอดคล้องกับโปรเจกต์ใหม่.
3. **ใช้**ส่วน “Key Decisions” เป็น checklist เพื่อหลีกเลี่ยงปัญหาเดิม (ADK import, root_agent, SSE parsing).
4. **นำ**ไฟล์ `.gitignore` ที่สร้างไว้แล้วมาใช้โดยตรง (แก้เฉพาะส่วนที่เกี่ยวกับเทคโนโลยีใหม่).

---

*Prepared by Antigravity – AI coding assistant*

---

```
# End of file
```

---
